<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Control de Velocidad de Video</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f0f0f0;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
        }
        video {
            max-width: 100%;
            border: 4px solid #333;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        #botonVelocidad {
            padding: 15px 30px;
            font-size: 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            margin-bottom: 20px;
        }
        #botonVelocidad:hover {
            background-color: #0056b3;
        }
        #panelVelocidad {
            display: none;
            flex-direction: column;
            align-items: center;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }
        .btnVel {
            padding: 10px 20px;
            font-size: 18px;
            margin: 10px;
            width: 180px;
            cursor: pointer;
            border: none;
            border-radius: 8px;
            color: white;
        }
        #subir { background: #28a745; }
        #bajar { background: #dc3545; }
        #reinicio { background: #6c757d; } /* Gris para rein
