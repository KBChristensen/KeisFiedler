<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="Admin.Master" CodeBehind="AddEditRemoveUser.aspx.cs" Inherits="KeisFiedlerShop.AddEditRemoveUser" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    
    <h3>Tilføj/rediger bruger:</h3>
    <table>
        <tr>
            <td><asp:Label ID="LabelAddUserName" runat="server">Brugernavn:</asp:Label></td>
            <td>
                <asp:TextBox ID="AddUserName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Text="* Indtast brugernavn." ControlToValidate="AddUserName" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td><asp:Label ID="LabelAddPassword" runat="server">Password:</asp:Label></td>
            <td>
                <asp:TextBox ID="AddPassword" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Text="* Indtast password." ControlToValidate="AddPassword" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td><asp:Label ID="LabelAddPrice" runat="server">Pris:</asp:Label></td>
            <td>
                <asp:TextBox ID="AddProductPrice" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Text="* Indtast pris på produkt." ControlToValidate="AddProductPrice" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" Text="* Angiv pris i tal." ControlToValidate="AddProductPrice" SetFocusOnError="True" Display="Dynamic" ValidationExpression="^[0-9]*(\.)?[0-9]?[0-9]?$"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td><asp:Label ID="LabelAddImageFile" runat="server">Billede:</asp:Label></td>
            <td>
                <asp:FileUpload ID="ProductImage" runat="server" />
            </td>
        </tr>
    </table>
    <p></p>
    <p></p>
    <asp:Button ID="AddProductButton" runat="server" Text="Tilføj produkt"  CausesValidation="true"/>
    <asp:Label ID="LabelAddStatus" runat="server" Text=""></asp:Label>
    <p></p>
</asp:Content>
