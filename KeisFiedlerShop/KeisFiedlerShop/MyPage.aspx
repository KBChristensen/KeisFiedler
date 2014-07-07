<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="Site.Master" CodeBehind="MyPage.aspx.cs" Inherits="KeisFiedlerShop.DinSide" %>
<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    Brugernavn: <br />
    <asp:Label runat="server" ID="usernameLabel"  /><br />
    Adresse: <br />
    <asp:Label runat="server" ID="addressLabel" /><br />
    Postnummer: <br />
    <asp:Label runat="server" ID="zipcodeLabel"  /><br />
    Email: <br />
    <asp:Label runat="server" ID="emailLabel" /><br />
    
    Ordrehistorik:
    <asp:ListBox runat="server" ID="transacthistoryListBox"/> 
</asp:Content>

