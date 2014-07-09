<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="Admin.Master" CodeBehind="AdminPage.aspx.cs" Inherits="KeisFiedlerShop.WebForm1" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server" >
    <h1 align="center">Site Administration</h1>
    <hr />
    <h3>Tilføj Produkt:</h3>
    <table>
        <tr>
            <td><asp:Label ID="LabelAddCategory" runat="server">Kategori:</asp:Label></td>
            <td>
                <asp:DropDownList ID="DropDownAddCategory" runat="server" ItemType="" SelectMethod=""> 
                
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td><asp:Label ID="LabelAddName" runat="server">Navn:</asp:Label></td>
            <td>
                <asp:TextBox ID="AddProductName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Text="* Indtast navn på produkt." ControlToValidate="AddProductName" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td><asp:Label ID="LabelAddDescription" runat="server">Beskrivelse:</asp:Label></td>
            <td>
                <asp:TextBox ID="AddProductDescription" TextMode="MultiLine" runat="server"></asp:TextBox>
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
    <h3>Fjern Produkt:</h3>
    <table>
        <tr>
            <td><asp:Label ID="LabelRemoveProduct" runat="server">Produkt:</asp:Label></td>
            <td><asp:DropDownList ID="DropDownRemoveProduct" ItemType="KeisFiedlerShop.Product" runat="server" >
                </asp:DropDownList>
            </td>
        </tr>
    </table>
    <p></p>
    <asp:Button ID="RemoveProductButton" runat="server" Text="Fjern produkt" CausesValidation="false"/>
    <asp:Label ID="LabelRemoveStatus" runat="server" Text=""></asp:Label>
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
