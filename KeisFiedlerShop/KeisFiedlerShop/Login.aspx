<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Login.aspx.cs" Inherits="KeisFiedlerShop.Login" %>

<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <div class="text-center">
        Brugernavn: <br />
        <asp:TextBox runat="server" ID="usernameTextBox" /><br />
        Password: <br />
        <asp:TextBox runat="server" ID="passwordTextBox" /><br />
        <asp:Button runat="server" ID="loginBtn" OnClick="loginBtn_OnClick" Text="Log ind"/><br /><br />
        <asp:Button runat="server" ID="registerBtn" OnClick="registerBtn_OnClick" Text="Opret Bruger"/>
        <asp:Label runat="server" Visible="False" ID="loginErrorLabel"></asp:Label>
    </div>
</asp:Content>
