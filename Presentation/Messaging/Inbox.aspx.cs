using Common.Attributes;
using LogicBusiness.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;

namespace Presentation.Messaging
{
    public partial class Inbox : System.Web.UI.Page
    {
        private readonly MessagesService _messagesService;
        private readonly UserService _userService;

        public Inbox()
        {
            _messagesService = new MessagesService();
            _userService = new UserService();
        }

        MainPage MasterPage
        {
            get { return (MainPage)this.Master; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarUsuarios();
            }
        }

        private void CargarUsuarios(string filtro = "")
        {
            int usuarioId = ObtenerUsuarioLogueadoId();
            if (usuarioId == 0) return;

            // Obtener últimos mensajes
            var ultimosMensajes = _messagesService.ObtenerUltimosMensajes(usuarioId);

            // Obtener los IDs de usuarios con los que tienes mensajes
            var usuariosId = ultimosMensajes
                .Select(m => m.IdEmisor == usuarioId ? m.IdReceptor : m.IdEmisor)
                .Distinct()
                .ToList();

            // Obtener información de los usuarios
            var usuarios = _userService.ObtenerUsuariosPorIds(usuariosId);

            // Asignar foto de perfil
            foreach (var u in usuarios)
            {
                string rutaFoto = _userService.ObtenerFotoPerfil(u.IdUsuario);
                if (string.IsNullOrEmpty(rutaFoto))
                    rutaFoto = "~/Resources/perfiles/default.png";

                u.FotoPerfil = ResolveUrl(rutaFoto);
            }

            // Filtrar por nombre si hay texto en la búsqueda
            if (!string.IsNullOrEmpty(filtro))
            {
                usuarios = usuarios
                    .Where(u => u.Nombre != null && u.Nombre.IndexOf(filtro, StringComparison.OrdinalIgnoreCase) >= 0)
                    .ToList();
            }

            // Asignar al Repeater y mostrar
            rptUsuarios.DataSource = usuarios;
            rptUsuarios.DataBind();
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            string filtro = txtBuscarUsuario.Text.Trim();
            CargarUsuarios(filtro);
        }

        private int ObtenerUsuarioLogueadoId()
        {
            if (Session["IdUsuario"] != null)
                return Convert.ToInt32(Session["IdUsuario"]);
            else
                MasterPage.MostrarModal("Error", "Usuario no logueado.");

            return 0;
        }

        protected void btnNuevoChat_Click(object sender, EventArgs e)
        {
            Response.Redirect("../Messaging/NewChat.aspx");
        }
        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            txtBuscarUsuario.Text = "";
            CargarUsuarios();           
        }

    }
}
