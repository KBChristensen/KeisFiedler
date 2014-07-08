<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="Site.Master" CodeBehind="Products.aspx.cs" Inherits="KeisFiedlerShop.Products" %>

<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <asp:TreeView runat="server" ID="ProductTreeView">
        <Nodes>
            <asp:TreeNode Text="Kopper"></asp:TreeNode>
        </Nodes>
    </asp:TreeView>
    
    <asp:Image runat="server" ImageUrl="http://keisfiedler.dk/picture/images/produkter/1.jpg"/>
    
</asp:Content>
