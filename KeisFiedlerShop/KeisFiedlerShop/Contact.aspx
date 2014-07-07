<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="KeisFiedlerShop.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>
    <h3>Your contact page.</h3>
    <address>
        Rodelundvej 62<br />
        8680 Ry<br />
        <abbr title="Phone">P:</abbr>
        +45 21912910
    </address>

    <address>
        <strong>Support:</strong>   <a href="mailto:mail@keisfiedler.dk">Support@example.com</a><br />
    </address>
</asp:Content>
