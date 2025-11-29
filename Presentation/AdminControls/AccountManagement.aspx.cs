using System;
using System.Linq;
using System.Collections.Generic;
using LogicBusiness.Service;
using System.Web.UI.WebControls;
using LogicBusiness.Helpers;
using Common.Entities;

namespace Presentation.AdminControls
{
    public partial class AccountManagement : System.Web.UI.Page
    {
        private readonly UserService userService = new UserService();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                CargarCuentas();
        }
        MainPage MasterPage
        {
            get { return (MainPage)this.Master; }
        }

        private void CargarCuentas()
        {
            var datos = userService.ObtenerUsuarios();

            // Filtro por tipo
            if (!string.IsNullOrEmpty(ddlRol.SelectedValue))
                datos = datos.Where(x => x.Rol.ToLower() == ddlRol.SelectedValue.ToLower()).ToList();

            // Búsqueda
            if (!string.IsNullOrWhiteSpace(txtBusqueda.Text))
            {
                var q = txtBusqueda.Text.Trim().ToLower();
                datos = datos.Where(x =>
                    (x.Nombre ?? "").ToLower().Contains(q) ||
                    (x.Correo ?? "").ToLower().Contains(q)
                ).ToList();
            }

            gvCuentas.DataSource = datos;
            gvCuentas.DataBind();
        }

        protected void btnFiltrar_Click(object sender, EventArgs e)
        {
            CargarCuentas();
        }

        protected void gvCuentas_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvCuentas.PageIndex = e.NewPageIndex;
            CargarCuentas();
        }

        protected void gvCuentas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            var idUsuario = Convert.ToInt32(e.CommandArgument);

            switch (e.CommandName)
            {
                case "Deshabilitar":
                    try
                    {
                        userService.EliminarUsuario(idUsuario);
                        CargarCuentas();
                        MasterPage.MostrarModal("Éxito", "Usuario deshabilitado correctamente.");
                        break;
                    }
                    catch (Exception ex)
                    {
                        MasterPage.MostrarModal("Error", "Error al deshabilitar el usuario: " + ex.Message);
                        break;
                    }
            }
        }
    }
}