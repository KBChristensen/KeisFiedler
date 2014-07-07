<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Login.aspx.cs" Inherits="KeisFiedlerShop.Login" %>

<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    Brugernavn: <br />
    <asp:TextBox runat="server" ID="usernameTextBox"  /><br />
    Password: <br />
    <asp:TextBox runat="server" ID="passwordTextBox" /><br />
    <asp:Button runat="server" ID="loginBtn" OnClick="loginBtn_OnClick" Text="Log ind"/>
</asp:Content>
