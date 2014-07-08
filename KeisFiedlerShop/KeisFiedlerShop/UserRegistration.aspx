<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="Site.Master" CodeBehind="UserRegistration.aspx.cs" Inherits="KeisFiedlerShop.UserRegistration" %>

<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    Brugernavn: <br />
    <asp:TextBox runat="server" ID="usernameTextBox" /><br />
    Password: <br />
    <asp:TextBox runat="server" ID="passwordTextBox" /><br />
    Gentag Password: <br />
    <asp:TextBox runat="server" ID="repeatpasswordTextBox" /><br />
    Navn: <br />
    <asp:TextBox runat="server" ID="nameTextBox" /><br />
    Adresse: <br />
    <asp:TextBox runat="server" ID="adressTextBox" /><br />
    Postnummer: <br />
    <asp:TextBox runat="server" ID="zipcodeTextBox" /><br />
    Email:
    <asp:TextBox runat="server" ID="emailTextBox" /><br />
    
    <asp:Button runat="server" ID="registerBtn" OnClick="registerBtn_OnClick" Text="Registrer oplysninger"/>

</asp:Content>
