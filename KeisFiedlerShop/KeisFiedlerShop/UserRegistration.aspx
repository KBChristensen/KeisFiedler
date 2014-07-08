<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="Site.Master" CodeBehind="UserRegistration.aspx.cs" Inherits="KeisFiedlerShop.UserRegistration" %>

<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <br />
    Brugernavn: <br />
    <asp:TextBox runat="server" ID="usernameTextBox" />
    <asp:RequiredFieldValidator runat="server" ControlToValidate="usernameTextBox" ErrorMessage="Indtast brugernavn." /> <br />
    Password: <br />
    <asp:TextBox runat="server" ID="passwordTextBox" /><br />
    Gentag Password: <br />
    <asp:TextBox runat="server" ID="repeatpasswordTextBox" />
    <asp:CompareValidator ID="passCompValidator" Type="String" ControlToValidate="passwordTextBox" ControlToCompare="repeatpasswordTextBox" ForeColor="#800000" Operator="Equal" Text="Password er ikke ens." runat="server"  /><br/>
    Navn: <br />
    <asp:TextBox runat="server" ID="nameTextBox" />
    <asp:RequiredFieldValidator runat="server" ControlToValidate="nameTextBox" ErrorMessage="Indtast dit fulde navn." /> <br />
    Adresse: <br />
    <asp:TextBox runat="server" ID="adressTextBox" />
    <asp:RequiredFieldValidator runat="server" ControlToValidate="adressTextBox" ErrorMessage="Indtast din adresse." /> <br />
    Postnummer: <br />
    <asp:TextBox runat="server" ID="zipcodeTextBox" />
    <asp:CompareValidator ID="ZipCompValidator" runat="server" Type="Integer" ControlToValidate="zipcodeTextBox" Operator="DataTypeCheck" ForeColor="#800000" Text="Postnummeret er forkert." /><br />
    Email:<br />
    <asp:TextBox runat="server" ID="emailTextBox" />
    <asp:RequiredFieldValidator runat="server" ControlToValidate="emailTextBox" ErrorMessage="Indtast din email." /> <br />
    
    <asp:Button runat="server" ID="registerBtn" OnClick="registerBtn_OnClick" Enabled="True" Text="Registrer oplysninger"/><br />
    
</asp:Content>
