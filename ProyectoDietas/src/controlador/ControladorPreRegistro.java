package controlador;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pojos.Usuario;
import modelo.AccessUsuarioDAO;
import modelo.ConexionBD;

/**
 * Servlet implementation class ControladorPreRegistro
 */
@WebServlet("/ControladorPreRegistro")
public class ControladorPreRegistro extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ControladorPreRegistro() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// para la tabla usuario
		String correo="";
		String contrasena="";
		String confirmaContrasena="";
		String nombre="";
		String apellidos="";
		String TipoUsuario="1";
		String sexo="";
	
		
		//para tabla direccion
		String calle="";
		String numeroExt="";
		String delMun="";


		
		//Jala todos los datos del formulario y se inicializan
		correo=request.getParameter("correo");
		contrasena=request.getParameter("contrasena");
		confirmaContrasena=request.getParameter("confirmaContrasena");
		nombre=request.getParameter("nombre");
		apellidos=request.getParameter("apellidos");
		calle=request.getParameter("calle");
		numeroExt=request.getParameter("numeroExt");
		delMun=request.getParameter("ciudad");
		sexo=request.getParameter("sexo");
		AccessUsuarioDAO gestor=new AccessUsuarioDAO();
		String us="";
		
		try {
			us=gestor.isUserResgistered(correo);
		} catch (SQLException e1) {
			System.out.println("Error buscando usuario por correo");
			e1.printStackTrace();
		}
		
		
		if(contrasena.equals(confirmaContrasena)&&us.equals("")){//si las contraseñas son iguales se procesan
		try {

			//registramos en tabla Usuario
			gestor.insertinUsuario(nombre, apellidos, correo, contrasena,sexo,TipoUsuario);
			//registramos en tabla direccion
			gestor.insertinDireccion(delMun, calle, numeroExt);
			String idDireccion=gestor.selectLastID();
			System.out.println(idDireccion);
			gestor.insertPaciente(gestor.getIdUsuario(correo), "0", idDireccion);
		} catch (SQLException e) {
						e.printStackTrace();
						System.out.println("Error al insertar usuario");
		}
		response.sendRedirect("index.jsp");
		}else{
			response.sendRedirect("ErrorPassPreRegistro.html");
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}