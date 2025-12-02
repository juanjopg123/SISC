<%@ Page Title="Bandeja de Entrada" Language="C#" MasterPageFile="~/MainPage.Master" AutoEventWireup="true" CodeBehind="Inbox.aspx.cs" Inherits="Presentation.Messaging.Inbox" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-xl mt-3 mt-lg-4 mb-4">

        <!-- Buscador -->
        <div class="search-box">
            <div class="search-row">
                <asp:TextBox ID="txtBuscarUsuario" runat="server"
                    CssClass="search-input"
                    Placeholder="Buscar usuario…" />

                <asp:Button ID="btnBuscar" runat="server" Text="Buscar"
                    CssClass="btn-buscar" />
            </div>
        </div>

        <!-- Header Nuevo Chat -->
        <div class="header-chat d-flex justify-content-between align-items-center">
            <h6 class="header-title mb-0">Conversaciones</h6>

            <asp:Button ID="btnNuevoChat" runat="server" Text="+ Nuevo chat"
                CssClass="btn-nuevo-chat"
                onClick="btnNuevoChat_Click"/>
        </div>

        <!-- Lista de usuarios -->
        <div class="user-list">
            <asp:Repeater ID="rptUsuarios" runat="server">
                <ItemTemplate>
                    <div class="inbox-user"
                        onclick="abrirConversacion(<%# Eval("IdUsuario") %>, '<%# Eval("Nombre") %>')">

                        <div class="user-avatar me-3"></div>

                        <div class="flex-fill">
                            <div class="user-name"><%# Eval("Nombre") %></div>
                            <small class="text-muted">Abrir conversación</small>
                        </div>

                        <span class="user-online"></span>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <script>
        function abrirConversacion(idUsuario) {
            window.location.href = 'Chat.aspx?usuarioId=' + idUsuario;
        }
    </script>

</asp:Content>
