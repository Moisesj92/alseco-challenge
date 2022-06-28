# Instrucciones

## Descripción

  Este es un proyecto para la venta de productos entre 3 tipos de usuarios ( Clientes, Minoristas y proveedores ) en el que los usuarios podrán comprar y vender sus productos.

## Requisitos

  Este proyecto necesita Docker para funcionar asi que lo primero que debes hacer es instalar docker desde su pagina oficial.

## Puesta en marcha

  Lo primero es crear nuestros contenedores con el siguiente comando:

  ``` Docker compose up ```

  Una vez se hayan descargado y ejecutado los containers deberás iniciar el contenedor en caso de que no lo este ya:

  ``` Docker ps --all ```

  ``` Docker container [ID_CONTAINER_BD] start```

  ``` Docker container [ID_CONTAINER_WEB] start```


  Luego deberás conectarte al contenedor **WEB** con el siguiente comando:

  ``` Docker container exec -it [ID_CONTAINER_WEB] bash``` 

  cuando estés dentro del contenedor debes ejecutar los comandos para instalar rails, la base de datos e iniciar el servidor

  ``` bundle install ```

  ``` rails db:create ```

  ``` rails db:migrate ```

  ``` rails db:seed ```

  ``` rails s -b 0.0.0.0 ```

  Si todo salio bien podrás empezar a realizar request con alguna herramienta como **Postman** hacia el recién creado API





