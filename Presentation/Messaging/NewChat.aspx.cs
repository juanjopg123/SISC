using Common.Attributes;
using LogicBusiness.Service;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Presentation.Messaging
{
    public partial class NewChat : System.Web.UI.Page
    {
        private readonly UserService _userService;

        public NewChat()
        {
            _userService = new UserService();
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

            var usuarios = _userService.ObtenerUsuarios(filtro)
                .Where(u => u.IdUsuario != usuarioId)
                .ToList();

            // Asignar foto de perfil a cada usuario
            foreach (var u in usuarios)
            {
                string rutaFoto = _userService.ObtenerFotoPerfil(u.IdUsuario);
                if (string.IsNullOrEmpty(rutaFoto))
                {
                    rutaFoto = "~/Resources/perfiles/default.png"; // ruta de foto por defecto
                }

                u.FotoPerfil = ResolveUrl(rutaFoto);
            }

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

            throw new Exception("Usuario no logueado.");
        }
    }
}
