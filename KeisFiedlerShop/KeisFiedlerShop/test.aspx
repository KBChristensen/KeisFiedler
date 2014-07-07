<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="test.aspx.cs" Inherits="KeisFiedlerShop.test" %>


<asp:Content ContentPlaceHolderID="MainContent" runat="server">
        <asp:FileUpload ID="FileUploadControl" runat="server"/>
        <asp:Button ID="testBtn" OnClick="BtnClick" runat="server" Text="Button" />
</asp:Content>    


    
    
