<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="Admin.Master" CodeBehind="AddEditRemoveCategory.aspx.cs" Inherits="KeisFiedlerShop.AddEditRemoveCategory" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    
    <h3>Tilføj kategori:</h3>
    <table>
        <tr>
            <td><asp:Label ID="CategoryNameLabel" runat="server">Navn:</asp:Label></td>
            <td>
                <asp:TextBox ID="AddCategoryName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Text="* Indtast navn på kategori." ControlToValidate="AddCategoryName" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td><asp:Label ID="CategoryDescLabel" runat="server">Beskrivelse:</asp:Label></td>
            <td>
                <asp:TextBox ID="CategoryDescTextBox" TextMode="MultiLine" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td><asp:Label ID="CategoryImgLabel" runat="server">Billede:</asp:Label></td>
            <td>
                <asp:FileUpload ID="CategoryImgFileUpload" runat="server" />
            </td>
        </tr>
    </table>
    <p></p>
    <p></p>
    <asp:Button ID="AddCategoryButton" runat="server" Text="Tilføj kategori" CausesValidation="true"/>
    <asp:Label ID="LabelAddStatus2" runat="server" Text=""></asp:Label>
    <p></p>
    <h3>Fjern kategori:</h3>
    <table>
        <tr>
            <td><asp:Label ID="FjernKategoriLabel" runat="server">Kategori:</asp:Label></td>
            <td><asp:DropDownList ID="FjernKategoriDropDownList" runat="server" >
                </asp:DropDownList>
            </td>
        </tr>
    </table>
    <p></p>
    <asp:Button ID="FjernKategoriButton" runat="server" Text="Fjern kategori" CausesValidation="false"/>
    <asp:Label ID="LabelAddStatus3" runat="server" Text=""></asp:Label>
</asp:Content>
