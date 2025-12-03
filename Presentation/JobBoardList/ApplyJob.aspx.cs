using System;
using System.IO;
using System.Web.UI;
using LogicBusiness.Service;
using Common.Attributes;

namespace Presentation.JobBoardList
{
    public partial class ApplyJob : Page
    {
        private readonly ApplicationsService _applicationsService = new ApplicationsService();

        protected void Page_Load(object sender, EventArgs e)
        {
            lblError.Visible = false;
            alertExito.Visible = false;

            if (!IsPostBack)
            {
                // Validar que venga ID de oferta en query string
                if (Request.QueryString["id"] != null && int.TryParse(Request.QueryString["id"], out int idOferta))
                {
                    hfIdOferta.Value = idOferta.ToString();  // Guardamos el ID en HiddenField
                }
                else
                {
                    pnlFormulario.Visible = false;  // Ocultar el formulario si no hay ID válido
                    ShowError("No se ha especificado una oferta válida para postular.");
                }
            }
        }

        protected void btnPostular_Click(object sender, EventArgs e)
        {
            try
            {
                // Validar sesión
                if (Session["IdUsuario"] == null)
                {
                    ShowError("Debes iniciar sesión para postularte.");
                    return;
                }

                int idEgresado = Convert.ToInt32(Session["IdUsuario"]);

                // Validar ID de oferta desde HiddenField
                if (!int.TryParse(hfIdOferta.Value, out int idOferta))
                {
                    ShowError("ID de oferta inválido.");
                    return;
                }

                // Validar archivo
                if (!fuCV.HasFile)
                {
                    ShowError("Selecciona un archivo PDF.");
                    return;
                }

                string ext = Path.GetExtension(fuCV.FileName).ToLower();
                if (ext != ".pdf")
                {
                    ShowError("Solo se permiten archivos PDF.");
                    return;
                }

                const int maxSize = 5 * 1024 * 1024; // 5 MB
                if (fuCV.PostedFile.ContentLength > maxSize)
                {
                    ShowError("El archivo supera el tamaño máximo de 5 MB.");
                    return;
                }

                // Guardar archivo en carpeta CVs
                string carpetaCV = Server.MapPath("~/Presentation/Resources/CVs/");
                if (!Directory.Exists(carpetaCV))
                {
                    Directory.CreateDirectory(carpetaCV);
                }

                string nombreArchivo = $"CV_{idEgresado}_{Guid.NewGuid()}.pdf";
                string rutaArchivo = Path.Combine(carpetaCV, nombreArchivo);
                fuCV.SaveAs(rutaArchivo);

                // Crear postulación
                var postulacion = new AttributesApplications
                {
                    IdEgresado = idEgresado,
                    IdOferta = idOferta,
                    FechaPostulacion = DateTime.Now,
                    EstadoFinal = AttributesApplications.EstadoPostulacion.Postulado,
                    CvUrl = "/Presentation/Resources/CVs/" + nombreArchivo,
                    Mensaje = "Postulación enviada correctamente."
                };

                // Guardar en base de datos
                _applicationsService.Agregar(postulacion);

                // Mostrar mensaje de éxito
                ((MainPage)Master).MostrarModal("Éxito", "¡Tu postulación ha sido enviada exitosamente!");
            }
            catch (Exception ex)
            {
                ShowError("Ocurrió un error: " + ex.Message);
            }
        }

        private void ShowError(string mensaje)
        {
            lblError.Text = mensaje;
            lblError.Visible = true;
            alertExito.Visible = false;
        }
    }
}
