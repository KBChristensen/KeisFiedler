<?php
// All the stuff for the new config menu goes in here
function lingotek_config_filter_inline_submit($form, $form_state) {
  unset($_SESSION['grid_filters']['textgroup']);
  $_SESSION['grid_filters']['textgroup'] = $form_state['values']['search_type'];
  if (!empty($form_state['values']['search'])) {
    $_SESSION['grid_filters']['search'] = $form_state['values']['search'];
  }
  else {
    unset($_SESSION['grid_filters']['search']);
  }

  if (isset($form_state['values']['limit_select'])) {
    $_SESSION['limit_select'] = $form_state['values']['limit_select'];
  }
}

function lingotek_config_header() {
  $header = array(// Define the tentative source header
    'lid' => array('data' => t('ID'), 'field' => 'lid', 'width' => '2%'),
    'set_name' => array('data' => t('Config Set Name'), 'field' => 'set_id', 'width' => '15%'),
    'source' => array('data' => t('Source'), 'field' => 'source', 'width' => '25%'),
    'source_uploaded' => array('data' => t('Source Uploaded')),
    'translations' => array('data' => t('Translations'), 'field' => 'current_target_count'),
    'location' => array('data' => t('Location'), 'field' => 'location'),
    'context' => array('data' => t('Context'), 'field' => 'context'),
    'doc_id' => array('data' => t('Doc ID'), 'field' => 'document_id', 'display' => 'none'),
    'textgroup' => array('data' => t('Textgroup'), 'field' => 'textgroup'),
  );

  return $header;
}

function lingotek_config_get_rows($entity_type, $form, &$form_state, $count_only = FALSE) {
  $columns = isset($form_state['values']['columns']) ? $form_state['values']['columns'] : array();
  $header = lingotek_config_header();
  $form_state['values']['grid_header'] = lingotek_bulk_grid_refine_source_header($header, $columns);
  $query = lingotek_config_start_query($form_state);
  lingotek_config_add_query_filters($query);

  if ($count_only) {
    $result = $query->execute();
    return $result->rowCount();
  }

  $limit = isset($_SESSION['limit_select']) ? $_SESSION['limit_select'] : 10;
  $table_data_raw = $query->extend('PagerDefault')
      ->limit($limit)
      ->execute()
      ->fetchAllAssoc('lid');

  $table_data = lingotek_bulk_grid_parse_config_data($table_data_raw, $entity_type);

  return $table_data;
}

function lingotek_config_add_existing_translations($lids, $lang_codes) {
  $query = db_select('locales_target', 'lt')
      ->fields('lt', array('lid', 'language'));
  $query->condition('lid', $lids, 'IN');
  $result = $query->execute()->fetchAll();

  $existing_translations = array();
  foreach ($result as $key => $value) {
    $lang = Lingotek::convertDrupal2Lingotek($value->language);
    // This check is performed in lang_icons anyway so you might remove it
    if (array_key_exists($lang, $lang_codes)) {
      $existing_translations[$value->lid][] = Lingotek::convertDrupal2Lingotek($value->language);
    }
  }
  return $existing_translations;
}

function lingotek_config_start_query($form_state) {
  $query = db_select('locales_source', 's')
      ->extend('TableSort')
      ->orderByHeader($form_state['values']['grid_header']);

  // Gets sync statuses for each language.
  $query->addExpression("(SELECT COUNT(*) FROM {locales_target} target LEFT JOIN {lingotek_config_map} map ON map.lid = target.lid WHERE map.lid = s.lid AND map.current = 1 AND target.i18n_status = 0)", 'current_target_count');
  $query->addExpression("(SELECT GROUP_CONCAT(SUBSTRING(config_key, 20, 10)) FROM {lingotek_config_metadata} WHERE id = (SELECT set_id FROM {lingotek_config_map} WHERE lid = s.lid) AND config_key LIKE 'target_sync_status_%' AND value='PENDING')", 'pending');
  $query->addExpression("(SELECT GROUP_CONCAT(SUBSTRING(config_key, 20, 10)) FROM {lingotek_config_metadata} WHERE id = (SELECT set_id FROM {lingotek_config_map} WHERE lid = s.lid) AND config_key LIKE 'target_sync_status_%' AND value='READY')", 'ready');
  $query->addExpression("(SELECT GROUP_CONCAT(SUBSTRING(config_key, 20, 10)) FROM {lingotek_config_metadata} WHERE id = (SELECT set_id FROM {lingotek_config_map} WHERE lid = s.lid) AND config_key LIKE 'target_sync_status_%' AND value='CURRENT')", 'current');
  $query->addExpression("(SELECT GROUP_CONCAT(SUBSTRING(config_key, 20, 10)) FROM {lingotek_config_metadata} WHERE id = (SELECT set_id FROM {lingotek_config_map} WHERE lid = s.lid) AND config_key LIKE 'target_sync_status_%' AND value='EDITED')", 'edited');
  $query->addExpression("(SELECT GROUP_CONCAT(SUBSTRING(config_key, 20, 10)) FROM {lingotek_config_metadata} WHERE id = (SELECT set_id FROM {lingotek_config_map} WHERE lid = s.lid) AND config_key LIKE 'target_sync_status_%' AND value='UNTRACKED')", 'untracked');
  $query->addExpression("(SELECT GROUP_CONCAT(language) FROM {locales_target} WHERE lid = s.lid AND i18n_status = 1)", 'source_edited');
  $query->addExpression("(SELECT set_id FROM {lingotek_config_map} lcm WHERE lcm.lid = s.lid)", 'set_id');

  // Lingotek Document ID
  $query->leftJoin('lingotek_config_metadata', 'lingo_document_id', 'lingo_document_id.id = (SELECT set_id FROM lingotek_config_map WHERE lid = s.lid) AND lingo_document_id.config_key = \'document_id\'');
  $query->addField('lingo_document_id', 'value', 'document_id');

  // Entity Upload Status
  $query->leftJoin('lingotek_config_metadata', 'lingo_upload_status', 'lingo_upload_status.id = (SELECT set_id FROM lingotek_config_map WHERE lid = s.lid) AND lingo_upload_status.config_key = \'upload_status\' AND lingo_upload_status.value <> \'' . LingotekSync::STATUS_TARGET . '\'');
  $query->addField('lingo_upload_status', 'value', 'upload_status');
  $query->fields('s', array('source', 'location', 'context', 'lid', 'textgroup'));
  // Only show items in textgroups that are selected for translation on Config Settings page.
  $translatable_textgroups = LingotekConfigSet::getTextgroupsForTranslation() ? : array('no textgroups selected');
  $query->condition('s.textgroup', $translatable_textgroups, 'IN');

  // Hide taxonomy terms that use translate for i18n_mode.
  $translate_terms_subquery = db_select('taxonomy_vocabulary', 'tv');
  $translate_terms_subquery->fields('tv', array('vid'));
  $translate_terms_subquery->condition('tv.i18n_mode', LINGOTEK_TAXONOMY_TRANSLATE_VALUE);
  $translate_ids = $translate_terms_subquery->execute()->fetchCol();

  // Hide taxonomy terms that have custom fields.
  $custom_fields_subquery = db_select('taxonomy_vocabulary', 'tv');
  $custom_fields_subquery->fields('tv', array('vid'));
  $custom_fields_subquery->join('field_config_instance', 'fci', 'tv.machine_name = fci.bundle');

  $query->leftJoin('taxonomy_term_data', 'term_name', 'term_name.name = s.source AND term_name.vid NOT IN (' . implode(',', array_merge(array(-1), $translate_ids)) . ') AND term_name.vid NOT IN (' . $custom_fields_subquery . ')');
  $query->addField('term_name', 'tid', 'tid_from_name');

  $query->leftJoin('taxonomy_term_data', 'term_description', 'term_description.description = s.source AND term_description.vid NOT IN (' . implode(',', array_merge(array(-1), $translate_ids)) . ') AND term_description.vid NOT IN (' . $custom_fields_subquery . ')');
  $query->addField('term_description', 'tid', 'tid_from_description');

  // For all taxonomy terms, only show if it has a name or description.
  $or = db_or();
  $or->condition('s.textgroup', 'taxonomy', '<>');
  $or->isNotNull('term_name.tid');
  $or->isNotNull('term_description.tid');
  $query->condition($or);

  return $query;
}

function lingotek_config_add_query_filters($query) {
  if (!isset($_SESSION['grid_filters'])) {
    return;
  }
  $filters = $_SESSION['grid_filters'];
  if (isset($filters['search']) && strlen($filters['search'])) {
    $query->condition('source', '%' . $filters['search'] . '%', 'LIKE');
  }

  if (isset($filters['textgroup'])) {
    if ($filters['textgroup'] == 'interface') {
      $query->condition('textgroup', 'default');
    }
    elseif ($filters['textgroup'] == 'menu') {
      $query->condition('textgroup', 'menu');
    }
    elseif ($filters['textgroup'] == 'taxonomy') {
      $query->condition('textgroup', 'taxonomy');
    }
    elseif ($filters['textgroup'] == 'blocks') {
      $query->condition('textgroup', 'blocks');
    }
    elseif ($filters['textgroup'] == 'field') {
      $query->condition('textgroup', 'field');
    }
  }

  lingotek_filter_by_document_id($query, $filters);

  // Upload Status
  if (isset($filters['upload_status']) && $filters['upload_status'] != 'all') {
    $query->join('locales_target', 'lt', 'lt.lid = s.lid');
    if ($filters['upload_status'] == 'never') {
      $query->isNull('lingo_upload_status.value');
    }
    elseif ($filters['upload_status'] == LingotekSync::STATUS_EDITED) {
      // The edited status won't show in lingotek_config_metadata table so we need to check the i18n_status (1 == edited).
      $query->condition('lt.i18n_status', '1');
    }
    else {
      $query->condition('lingo_upload_status.value', $filters['upload_status']);
      // Do not include items with a source marked as edited in locales_target (1 == edited).
      $query->condition('lt.i18n_status', '0');
    }
  }
}

function lingotek_bulk_grid_parse_config_data($table_data_raw, $entity_type) {
  $lingotek_languages = Lingotek::getLanguages();

  $lids = array_keys($table_data_raw);
  $existing_translations = !empty($lids) ? lingotek_config_add_existing_translations($lids, $lingotek_languages) : array();

  $languages = language_list();
  $global_profile = lingotek_get_global_profile();
  $table_data = array();
  foreach ($table_data_raw as $row) {
    $lid = $row->{'lid'};
    $row->lingotek = $global_profile;
    $row->lingotek['profile'] = 1;
    $row->language = 'en';

    $locale_statuses = lingotek_build_locales_statuses($row, FALSE);
    $item_is_current = LingotekConfigSet::isLidCurrent($lid);
    $item_has_translations = array_key_exists($lid, $existing_translations);
    $source_was_edited = $row->source_edited && $item_is_current !== FALSE ? explode(',', $row->source_edited) : array();

    $item_belongs_to_set = !empty($locale_statuses);

    if ($source_was_edited) {
      $row->upload_status = LingotekSync::STATUS_EDITED;
      foreach ($source_was_edited as $key => $lang) {
        $locale = Lingotek::convertDrupal2Lingotek($lang);
        $locale_statuses[$locale] = 'edited';
      }
    }

    $not_uploaded_to_lingotek = !$item_has_translations && $item_is_current;
    ksort($locale_statuses);
    if ($item_belongs_to_set) {
      if ($not_uploaded_to_lingotek) {
        unset($locale_statuses);
        $locale_statuses = array();
        $row->upload_status = NULL;
      }
    }
    elseif ($item_has_translations) { // No translations in locales + translations in locales_target = Untracked.
      foreach ($existing_translations[$lid] as $existing_locale) {
        $locale_statuses[$existing_locale] = 'untracked';
      }
    }

    $escaped_source = htmlentities($row->{'source'});
    $source_text = lingotek_truncate_grid_text($escaped_source, 55);

    $translation_icons = lingotek_lang_icons($entity_type, $languages, $lid, $locale_statuses, FALSE, $row->language); // show translation statuses
    $target_icons_str = implode('', array_values($translation_icons));
    $icon = lingotek_source_uploaded_icon($row);
    $source_uploaded = lingotek_render_source($entity_type, $row, $icon, $languages, 'language');
    $set_id = LingotekConfigSet::getSetId($lid, FALSE);
    $set_name = $set_id !== FALSE ? LingotekConfigSet::getTitleBySetId($set_id) : t('N/A');

    $data = array(
      'lid' => $lid ? : t('??'),
      'source' => $source_text,
      'source_uploaded' => $source_uploaded,
      'location' => $row->{'location'},
      'context' => $row->{'context'},
      'textgroup' => $row->{'textgroup'} == 'default' ? 'built-in interface' : $row->{'textgroup'},
      'translations' => $target_icons_str,
      'doc_id' => $row->document_id ? $row->document_id : t('N/A'),
      'set_name' => '<span class="set_name">' . $set_name . '</span>'
    );

    $table_data[$lid] = $data;
  }
  return $table_data;
}

/**
 * Submit function for The Grid's actions
 * The action corresponds to the key of the option selected
 * Often redirects to batch operations or to other pages entirely
 */
function lingotek_config_action_submit($form, $form_state) {
  $lids = array();

  if (isset($form_state['clicked_button']) && $form_state['clicked_button']['#name'] == 'actions_submit') { // If submitting an action
    foreach ($form_state['values']['the_grid'] as $value) {
      if ($value != 0) {
        $lids[] = $value;
      }
    }

    if (isset($form_state['values']['actions_select'])) { // If an action was selected (which it would be, I don't know if this could ever NOT occur with normal use)
      $action = $form_state['values']['actions_select']; // Get the action
      if (count($lids) <= 0) { // Select a node
        drupal_set_message(t('You must select at least one node to @action.', array('@action' => $action)), 'warning'); // Or pay the price
      }
      elseif ($action == 'upload') { // If uploading
        lingotek_config_upload_selected($lids);
      }
      elseif (substr($action, 0, 8) == 'download') { // If downloading all targets
        lingotek_config_download_selected($lids);
      }
      elseif ($action == 'sync') { // If syncing the progress
        lingotek_config_update_selected($lids); // Run batch operations to get the progress report from Lingotek
      }
      elseif ($action == 'delete' || $action == 'reset') {
        // ajax ctools modal employed (see lingotek_bulk_grid_form() and lingotek.bulk_grid.js)
      }
    }
  }
}

function lingotek_config_upload_selected($lids) {
  $set_ids = array();
  // You need to iterate through this (with multiple db queries) because this function will also assign the item to a new set and create a new set if necessary. With one query to get all set_ids, it might not do that.
  foreach ($lids as $lid) {
    $set_id = LingotekConfigSet::getSetId($lid);
    $set_ids[] = $set_id;
  }
  $unique_set_ids = array_unique($set_ids);

  $edited_lids = !empty($unique_set_ids) ? LingotekConfigSet::getEditedLidsInSets($unique_set_ids) : array();
  $not_current_lids = array_merge($lids, $edited_lids);

  if (empty($not_current_lids)) {
    drupal_set_message(t('No config items have been edited and need to be uploaded at this time. To translate a config item for the first time, check the corresponding box and upload.'), 'status', FALSE);
    drupal_goto('admin/settings/lingotek/manage/config');
  }

  LingotekConfigSet::markLidsNotCurrent($not_current_lids);

  $batch = array(
    'title' => t('Uploading Content To Lingotek'),
    'finished' => 'lingotek_sync_upload_config_finished'
  );

  $operations = lingotek_get_sync_upload_config_batch_elements($unique_set_ids);
  $batch['operations'] = $operations;
  $redirect = 'admin/settings/lingotek/manage/config';

  batch_set($batch);
  batch_process($redirect); // Run batch operations to upload all of the selected nodes to Lingotek
}

function lingotek_config_download_selected($lids) {
  $set_ids = array_unique(LingotekSync::getSetIdsFromLids($lids));
  if (empty($set_ids)) {
    drupal_set_message(t('No translations to download at this time. Make sure configuration items have been uploaded to Lingotek before trying to get translations for them.'), 'status', FALSE);
    drupal_goto('admin/settings/lingotek/manage/config');
  }
  $document_ids = LingotekSync::getConfigDocIdsFromSetIds($set_ids);
  $available_targets = Lingotek::getLanguages();
  unset($available_targets['en_US']); // all locales_source is assumed by i18n modules to be English
  $download_targets = array();
  foreach ($document_ids as $doc_id) {
    foreach (array_keys($available_targets) as $lang) {
      $target = new stdClass();
      $target->document_id = $doc_id;
      $target->locale = $lang;
      $download_targets[] = $target;
    }
  }
  $redirect = 'admin/settings/lingotek/manage/config';
  $operations = lingotek_get_sync_download_batch_elements($download_targets, LingotekSync::STATUS_PENDING);
  $batch = array(
    'title' => t('Syncing Content and Translations'),
    'operations' => $operations,
    'file' => 'lingotek.batch.inc',
    'finished' => 'lingotek_sync_batch_finished'
  );
  batch_set($batch);
  batch_process($redirect);
}
