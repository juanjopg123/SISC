<%@ Page Title="Eventos" Language="C#" MasterPageFile="~/MainPage.Master" AutoEventWireup="true"
    CodeBehind="EventsLoad.aspx.cs" Inherits="Presentation.Events.EventsLoad" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="css/Main.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container eventos-container mt-5">

        <h2 class="text-center text-primary fw-bold mb-4">Eventos</h2>

        <!-- FILTROS -->
        <div class="card eventos-filtros shadow-sm p-4 mb-5">
            <div class="row g-3 align-items-end">

                <div class="col-md-4">
                    <label class="form-label fw-semibold">Título</label>
                    <asp:TextBox ID="txtBuscarTitulo" runat="server"
                        CssClass="form-control evento-input"
                        placeholder="Buscar por título..." />
                </div>

                <div class="col-md-2">
                    <label class="form-label fw-semibold">Desde</label>
                    <asp:TextBox ID="txtFechaInicioFiltro" runat="server"
                        CssClass="form-control evento-input"
                        TextMode="Date" />
                </div>

                <div class="col-md-2">
                    <label class="form-label fw-semibold">Hasta</label>
                    <asp:TextBox ID="txtFechaFinFiltro" runat="server"
                        CssClass="form-control evento-input"
                        TextMode="Date" />
                </div>

                <div class="col-md-2 text-center">
                    <asp:Button ID="btnLimpiarCampos" runat="server"
                        Text="Limpiar" CssClass="btn btn-primary w-100 evento-boton"
                        OnClick="btnLimpiarCampos_Click" />
                </div>

                <div class="col-md-2 text-center">
                    <asp:Button ID="btnBuscar" runat="server"
                        Text="Buscar" CssClass="btn btn-primary w-100 evento-boton"
                        OnClick="btnBuscar_Click" />
                </div>

            </div>
        </div>

        <!-- LISTA DE EVENTOS -->
        <div class="row g-4">
            <asp:Repeater ID="rptEventos" runat="server">
                <ItemTemplate>
                    <div class="col-md-3">
                        <div class="card evento-card shadow-sm border-0">

                            <img src='<%# Eval("RutaImagen") %>'
                                 class="card-img-top evento-img"
                                 alt="Imagen del evento">

                            <div class="card-body">
                                <h5 class="card-title text-dark fw-bold">
                                    <%# Eval("Titulo") %>
                                </h5>

                                <p class="card-text text-secondary descripcion">
                                    <%# Eval("Descripcion").ToString().Length > 90
                                            ? Eval("Descripcion").ToString().Substring(0, 90) + "..."
                                            : Eval("Descripcion") %>
                                </p>

                                <p class="text-muted small mb-1">
                                    <i class="bi bi-geo-alt"></i>
                                    <%# Eval("Lugar") %>
                                </p>

                                <p class="text-muted small">
                                    <i class="bi bi-calendar-event"></i>
                                    <%# string.Format("{0:dd/MM/yyyy}", Eval("FechaInicio")) %>
                                    -
                                    <%# Eval("FechaFin") != DBNull.Value ?
                                            string.Format("{0:dd/MM/yyyy}", Eval("FechaFin")) : "" %>
                                </p>

                                <a href="#"
                                   class="btn btn-primary w-100 evento-boton-detalle"
                                   data-bs-toggle="modal"
                                   data-bs-target="#detalleEventoModal"
                                   data-titulo='<%# Eval("Titulo") %>'
                                   data-descripcion='<%# Eval("Descripcion") %>'
                                   data-lugar='<%# Eval("Lugar") %>'
                                   data-fechainicio='<%# Eval("FechaInicio", "{0:dd/MM/yyyy HH:mm}") %>'
                                   data-fechafin='<%# Eval("FechaFin") != DBNull.Value ? Eval("FechaFin", "{0:dd/MM/yyyy HH:mm}") : "" %>'
                                   data-organizador='<%# Eval("Organizador") %>'
                                   data-tipo='<%# Eval("Tipo") %>'
                                   data-imagen='<%# Eval("RutaImagen") %>'
                                   onclick="cargarDetallesEvento(this)">
                                    Ver detalles
                                </a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <asp:Label ID="lblSinEventos" runat="server"
            CssClass="text-center text-muted d-block mt-4"
            Visible="false"
            Text="No hay eventos disponibles por el momento.">
        </asp:Label>

    </div>

    <!--  Modal Detalles -->
    <div class="modal fade" id="detalleEventoModal" tabindex="-1" aria-labelledby="detalleEventoLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header text-white" style="    background: linear-gradient(135deg, #002a3f, #004f6e);">
                    <h5 class="modal-title fw-bold" id="detalleEventoLabel">
                        <i class="bi bi-calendar-event me-2"></i>Detalles del Evento
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <div class="text-center mb-3">
                        <img id="imgEventoModal" src="~/Resources/events/default.png" alt="Imagen evento" class="img-fluid rounded shadow-sm" style="max-height: 300px; object-fit: cover;">
                    </div>
                    <h4 id="tituloEventoModal" class="fw-bold text-primary mb-3"></h4>
                    <p id="descripcionEventoModal" class="text-secondary"></p>
                    
                    <hr>
                    
                    <div class="row g-3">
                        <div class="col-md-6">
                            <p class="mb-2">
                                <i class="bi bi-geo-alt-fill text-danger me-2"></i>
                                <strong>Lugar:</strong> <span id="lugarEventoModal"></span>
                            </p>
                        </div>
                        <div class="col-md-6">
                            <p class="mb-2">
                                <i class="bi bi-tag-fill text-info me-2"></i>
                                <strong>Tipo:</strong> <span id="tipoEventoModal"></span>
                            </p>
                        </div>
                        <div class="col-12">
                            <p class="mb-2">
                                <i class="bi bi-calendar3 text-success me-2"></i>
                                <strong>Fecha:</strong> <span id="fechaEventoModal"></span>
                            </p>
                        </div>
                        <div class="col-12">
                            <p class="mb-0">
                                <i class="bi bi-person-fill text-warning me-2"></i>
                                <strong>Organizador:</strong> <span id="organizadorEventoModal"></span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="bi bi-x-circle me-1"></i>Cerrar
                    </button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
