<%@page import = 
    "pojos.Cita,
    pojos.Usuario,
    modelo.AccessUsuarioDAO,
    modelo.UsuarioDAO,
    controlador.AccessUser,
    java.util.ArrayList,
    modelo.CitaNutriologoDAO"%>
    <%!
    	Usuario user;
    %>
    <%
    user = (Usuario) session.getAttribute("Usuario");
    %>
    <%HttpSession sesion = request.getSession();
    	Usuario a = new Usuario();
    	a = (Usuario)sesion.getAttribute("Usuario");
    	String nombre = a.getNombre();
    %>
<!DOCTYPE html>
<html lang="es">
<head>
	<meta charset="utf-8">
	<meta name="viewport"    content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="css/boots.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
	<script src="js/Chart.js"></script>
	
	
</head>
<body>

<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-2">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">Logo</a>
    </div>

    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-2">
      <ul class="nav navbar-nav">
        <li class="active"><a href="#">Inicio <span class="sr-only">(current)</span></a></li>
		<li ><a href="#">Contacto</a></li>
        <li><a href="#">Mas de nosotros</a></li>
        
      </ul>
      
     
    </div>
  </div>
</nav>


<div class="container">
		<div class="row">
			<div class="col-md-12">			
				<h1>Citas del Paciente</h1>
				<div></div>
				<div style="width:50%">
				<h3>Hitorial</h3>
					<div>
						<table class = "table table-striped">
							<thead>
								<tr>
									<th>DÌa</th>
									<th>Mes</th>
									<th>AÒo</th>
									<th>Hora</th>
								</tr>
							</thead>
								<tbody>
									<tr>
										<td>18</td>
										<td>Diciembre</td>
										<td>2014</td>
										<td>13:30</td>
									</tr>
								</tbody>
						</table>
					</div>
				</div>
			</div>
			</div>
			
			<h3>Citas Agendadas</h3>
				<div>
				<div style="width:50%">
						<table class = "table table-striped">
							<thead>
								<tr>
									<th>DÌa</th>
									<th>Mes</th>
									<th>AÒo</th>
									<th>Hora</th>
									<th>Eliminar</th>
								</tr>
							</thead>
								<tbody>
									<tr>
										<td>18</td>
										<td>Agosto</td>
										<td>2015</td>
										<td>13:30</td>
										<td><button type="submit" class="btn btn-primary" >X</button></td>
									</tr>
								</tbody>
						</table>
				</div>
				
				
				<div>
						<form class = "form-horizontal">
							<fieldset>
								<div class="col-lg-1">
								<input class="form-control" id="D√≠a" placeholder="DÌa" type="text">
								<input class="form-control" id="Mes" placeholder="Mes" type="text">
								<input class="form-control" id="A√±o" placeholder="AÒo" type="text">
								</div>
								<div class="form-group">
								<div class="col-lg-10 col-lg-offset-2">
									<button type="submit" class="btn btn-primary">Agendar Cita</button>
								</div>
								</div>
							</fieldset>
						</form>
				</div>
			
				
		</div> <!-- /row -->

		

</div>	<!-- /container -->



<div class="container" style="margin-top:100px;background:#213029;color:#FFF;width:100%;">

		<div class="row">
			<div class="col-md-12">
			<p style="text-align:center;">Empresa</p>	
			
			</div>
			
		
			
			
		</div> <!-- /row -->
		<hr>
		<div class="row">
			<div class="col-md-4">
					Mas informaci√≥n
			
			</div>
			
		
			<div class="col-md-4">
				Datos legales
			</div>
			
			<div class="col-md-4">
				Conocenos
			</div>
			
		</div> <!-- /row -->

		

</div>	<!-- /container -->



</html>

