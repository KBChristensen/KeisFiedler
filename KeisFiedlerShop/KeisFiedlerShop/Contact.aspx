<%@ Page Title="Kontakt os" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="KeisFiedlerShop.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %></h2>
    <address>
        Rodelundvej 62<br />
        8680 Ry<br />
        Tlf: +45 21912910
    </address>
    
    Kontaktformular <br/>
    <asp:TextBox runat="server" TextMode="MultiLine" />
    
</asp:Content>
