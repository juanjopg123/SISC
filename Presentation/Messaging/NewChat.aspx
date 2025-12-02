<%@ Page Title="Nuevo Chat" Language="C#" MasterPageFile="~/MainPage.Master" AutoEventWireup="true" CodeBehind="NewChat.aspx.cs" Inherits="Presentation.Messaging.NewChat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="<%= ResolveUrl("~/css/newchat.css") %>" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="newchat-container container-xl mt-4 mt-lg-5 mb-5">

        <!-- Tarjeta principal -->
        <div class="newchat-card card border-0 shadow">
            <div class="card-body p-4 p-lg-5">

                <!-- Encabezado -->
                <header class="newchat-header d-flex justify-content-between align-items-start mb-4">
                    <div>
                        <h2 class="newchat-title fw-bold mb-1">Iniciar nuevo chat</h2>
                        <p class="newchat-subtitle mb-0">Busca un usuario y comienza una conversación privada.</p>
                    </div>

                    <span class="newchat-badge badge d-none d-md-inline-flex align-items-center">
                        Mensajes
                    </span>
                </header>

                <!-- Barra de búsqueda -->
                <section class="newchat-search mb-4">
                    <div class="row justify-content-center">
                        <div class="col-12 col-md-8 col-lg-6">

                            <div class="newchat-searchbar input-group input-group-lg">
                                
                                <span class="input-group-text newchat-icon">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="#00b2c1" viewBox="0 0 16 16">
                                        <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001l3.85 3.85a1 1 0 0 0 1.415-1.415l-3.85-3.85zm-5.242.656a5 5 0 1 1 0-10 5 5 0 0 1 0 10z" />
                                    </svg>
                                </span>

                                <asp:TextBox ID="txtBuscarUsuario" runat="server"
                                    CssClass="form-control newchat-input"
                                    Placeholder="Buscar usuario..." />

                                <asp:Button ID="btnBuscar" runat="server"
                                    CssClass="btn newchat-btn-search px-4"
                                    Text="Buscar" OnClick="btnBuscar_Click" />

                            </div>
                        </div>
                    </div>
                </section>

                <!-- Lista de usuarios -->
                <section class="newchat-list-section">
                    <div class="row justify-content-center">
                        <div class="col-12 col-md-10 col-lg-8">

                            <div class="newchat-list list-group list-group-flush overflow-auto" style="max-height: 60vh;">
                                
                                <asp:Repeater ID="rptUsuarios" runat="server">
                                    <ItemTemplate>

                                        <a href="javascript:void(0);"
                                           class="newchat-item list-group-item list-group-item-action d-flex align-items-center"
                                           onclick="iniciarChat(<%# Eval("IdUsuario") %>)">

                                            <!-- Avatar -->
                                            <div class="newchat-avatar me-3"></div>

                                            <!-- Información -->
                                            <div class="flex-grow-1">
                                                <span class="newchat-username fw-semibold h6 mb-0">
                                                    <%# Eval("Nombre") %>
                                                </span>
                                                <div class="newchat-hint small text-muted">Haz clic para chatear</div>
                                            </div>

                                            <!-- Icono -->
                                            <div class="newchat-arrow ms-3">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="text-muted" viewBox="0 0 16 16">
                                                    <path fill-rule="evenodd" d="M6.854 4.146a.5.5 0 0 1 .0.708L4.707 7l2.147 2.146a.5.5 0 0 1-.708.708l-2.5-2.5a.5.5 0 0 1 0-.708l2.5-2.5a.5.5 0 0 1 .708 0z" />
                                                    <path fill-rule="evenodd" d="M10.5 7.5a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 0 1h-3a.5.5 0 0 1-.5-.5z" />
                                                </svg>
                                            </div>

                                        </a>

                                    </ItemTemplate>
                                </asp:Repeater>

                            </div>

                        </div>
                    </div>
                </section>

            </div>
        </div>
    </div>

    <script>
        function iniciarChat(idUsuario) {
            window.location.href = 'Chat.aspx?usuarioId=' + idUsuario;
        }
    </script>

</asp:Content>
