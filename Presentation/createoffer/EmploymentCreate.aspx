<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmploymentCreate.aspx.cs"
    Inherits="Presentation.CreateOffer.EmploymentCreate" 
    MasterPageFile="~/MainPage.Master"
    ResponseEncoding="utf-8" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <link href="css/Main.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="employment-container">

        <h2 class="employment-title">Crear Oferta de Empleo</h2>
        <hr class="employment-separator" />

        <div class="row employment-form">

            <!-- TITULO -->
            <div class="col-md-6 mb-3">
                <label class="employment-label">Título</label>
                <asp:TextBox ID="txtTitulo" CssClass="form-control employment-input" runat="server" />
            </div>

            <!-- EMPRESA -->
            <div class="col-md-6 mb-3">
                <label class="employment-label">Empresa</label>
                <asp:TextBox ID="txtEmpresa" CssClass="form-control employment-input" runat="server" Enabled="false" />
            </div>

            <!-- CATEGORÍA -->
            <div class="col-md-12 mb-3">
                <label class="employment-label">Categoría</label>
                <asp:TextBox ID="txtCategoria" CssClass="form-control employment-input" runat="server" />
            </div>

            <!-- MODALIDAD -->
            <div class="col-md-6 mb-3">
                <label class="employment-label">Modalidad</label>
                <asp:DropDownList ID="ddlModalidades" CssClass="form-select employment-select" runat="server" />
            </div>

            <!-- TIPO DE CONTRATO -->
            <div class="col-md-6 mb-3">
                <label class="employment-label">Tipo de Contrato</label>
                <asp:DropDownList ID="ddlContratos" CssClass="form-select employment-select" runat="server" />
            </div>

            <!-- SALARIO -->
            <div class="col-md-6 mb-3">
                <label class="employment-label">Salario</label>
                <asp:TextBox ID="txtSalario" CssClass="form-control employment-input" TextMode="Number" runat="server" />
            </div>

            <!-- CIUDAD -->
            <div class="col-md-6 mb-3">
                <label class="employment-label">Ciudad</label>
                <asp:TextBox ID="txtCiudad" CssClass="form-control employment-input" runat="server" />
            </div>

            <!-- REQUISITOS -->
            <div class="col-md-12 mb-3">
                <label class="employment-label">Requisitos</label>
                <asp:TextBox ID="txtRequisitos" CssClass="form-control employment-textarea" TextMode="MultiLine" Rows="4" runat="server" />
            </div>

            <!-- DESCRIPCIÓN -->
            <div class="col-md-12 mb-3">
                <label class="employment-label">Descripción</label>
                <asp:TextBox ID="txtDescripcion" CssClass="form-control employment-textarea" TextMode="MultiLine" Rows="6" runat="server" />
            </div>

            <!-- FECHA DE CIERRE -->
            <div class="col-md-4 mb-3">
                <label class="employment-label">Fecha de Cierre</label>
                <asp:TextBox ID="txtFechaCierre" CssClass="form-control employment-input" TextMode="Date" runat="server" />
            </div>

            <!-- BOTÓN GUARDAR -->
            <div class="col-md-12 text-end mt-4">
                <asp:Button ID="btnGuardar" CssClass="btn employment-btn" Text="Publicar Oferta" runat="server"
                    OnClick="btnGuardar_Click" />
            </div>

            <asp:Label ID="lblMensaje" runat="server" Text="" CssClass="employment-message"></asp:Label>

        </div>
    </div>

</asp:Content>
