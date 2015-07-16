<!DOCTYPE html>
<html lang="es">
<head>
	<meta charset="utf-8">
	<meta name="viewport"    content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>	
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
			<div class="col-md-6">
				<div class="jumbotron">
				  <h1>Logo</h1>
					
					
					
					<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
					  <div class="panel panel-default">
						<div class="panel-heading" role="tab" id="headingOne">
						  <h4 class="panel-title">
							<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
							  Ingresar
							</a>
						  </h4>
						</div>
						<div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
						  <div class="panel-body">
							<form class="form-horizontal" action="Entra" method="post">
							  <fieldset>
								<legend>Legend</legend>
								<div class="form-group">
								 
								  <div class="col-lg-10">
									<input class="form-control" id="txtEmail" name ="txtEmail" placeholder="Usuario / Correo" type="text" required>
								  </div>
								</div>
								<div class="form-group">
								  <div class="col-lg-10">
									<input class="form-control" id="txtPass" name ="txtPass"placeholder="Contrase�a" type="password" required>
									<div class="checkbox">
									
									<% 
									HttpSession sesion = request.getSession();
									if(sesion.getAttribute("tipo") != null){
											if(sesion.getAttribute("tipo") != null){
												if(sesion.getAttribute("tipo").equals("UN"))
												out.println("<label id=\"error\">Usuario Invalido<label>");
												else if(sesion.getAttribute("tipo").equals("PN"))
													out.println("<label id=\"error\">Contrase�a incorrecta<label>");
												else if(sesion.getAttribute("tipo").equals("incorrecto"))
													out.println("<label id=\"error\">Contrase�a incorrecta<label>");
												else if(sesion.getAttribute("tipo").equals("DI"))
													out.println("<label id=\"error\">Campos incompletos<label>");
									
											}
									}
										
									%>
									  <label >
										<a href="#">Olvide mi contrase�a</a>
									  </label>
									</div>
								  </div>
								</div>
							
								
								<div class="form-group">
								  <div class="col-lg-10 col-lg-offset-2">
									<button type="submit" class="btn btn-primary">Aceptar</button>
								  </div>
								</div>
							  </fieldset>
							</form>
							
							
							
						  </div>
						</div>
					  </div>
					  <div class="panel panel-default">
						<div class="panel-heading" role="tab" id="headingTwo">
						  <h4 class="panel-title">
							<a href="preregistro.html">
							  Registrarme
							</a>
						  </h4>
						</div>
						<div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
						  <div class="panel-body">
							Datos de registro
						  </div>
						</div>
					  </div>
					 
					</div>
					
					
					
				 
				 <a href="#">�Estas buscando clinica?</a>
				 <br/>
				 <a href="#">Con�cete y cu�date: IMC</a>
				  
				  
				  
				</div>
			
			</div>
			
		
			<div class="col-md-6">
				<div class="jumbotron">
				  <h2>�Qui�nes somos?</h2>
				  <p>Nuestro objetivo es ofrecrer una herramienta que facilite la vinculaci�n entre el paciente y el nutri�logo</p>
				  
				  <h2>�Qu� ofrecemos?</h2>
				  <p>Como paciente</p>
				  <h3>Seguimiento de tu dieta</h3>
				  <p>Como doctor</p>
				  <h3>Seguimiento de tus pacientes</h3>
				  <p><a class="btn btn-success">Mas informaci�n</a></p>
				  
				</div>
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
					Mas informaci�n
			
			</div>
			
		
			<div class="col-md-4">
				Datos legales
			</div>
			
			<div class="col-md-4">
				Con�cenos
			</div>
			
		</div> <!-- /row -->

		

</div>	<!-- /container -->


</body>

</html>

