const express = require("express");
const app = express();
const cors = require("cors");
const jwt = require("jsonwebtoken")
const { obtenerProductosId, login, registrarUsuario,obtenerUsuario,comprar, obtenerPublicaciones,agregarCarro,descontar,incrementar,borrarcarro,modificarUsuario,obtenerCompras,obtenerPublicacionesUser,registrarProductos } = require("./conexion")
const { reporteConsultas} = require("./middlewares/miders")

const port = process.env.PORT || 3000;

const params =  process.env.PARAMS

app.listen(port,()=>console.log("Servidor Activo Puerto 3000"));

app.use(cors());
app.use(express.json())


app.post("/usuarios", reporteConsultas,async (req, res)=>{
    try {
        const usuario = req.body
        await registrarUsuario(usuario)
        res.send("Usuario creado con exito...")
    } catch (error) {
        res.status(500).send(error)
        console.log(error);
    }
})

// Agregar esta ruta para obtener el usuario logueado
app.get("/usuario", reporteConsultas, async (req, res)=>{
    try {
        const Authorization = req.header("Authorization")
        const token = Authorization.split("Bearer ")[1]
        jwt.verify(token, params)
        const { email } = jwt.decode(token)
        const usuario = await obtenerUsuario(email)
        res.send(usuario)
    } catch (error) {
        res.status(500).send(error)
        console.log(error);
    }
     
    
})
//Ruta para editar el usuario que se obtiene en la ruta anterior
app.put("/usuario/:id", async (req, res) => {
    const { id } = req.params
    const usuario = req.body
    await modificarUsuario(usuario,id)
    res.send("Usuario modificado con éxito")
})
    

app.post("/login",reporteConsultas, async (req, res)=>{
    try {
        let data = {}
        const { email, password } = req.body
        const result=await login(email,password)
        const jsResult = JSON.stringify(result)
        const token = jwt.sign({email},"Za_Za")
        data = {token,jsResult}
        console.log(data);
        res.send(data)
    } catch (error) {
        console.log(error);
        res.status(error.code || 500).send(error)
    }
})

app.post("/SaleProduct", reporteConsultas,async (req, res)=>{
    try {
        const compra = req.body
        await comprarPublicacion(compra)
        res.send("Compra creada con exito...")
    } catch (error) {
        res.status(500).send(error)
        console.log(error);
    }
})

//crear nueva publicacion
app.post("/usuario/publicaciones", async (req, res) => {
    try {
      const publicacion = req.body
      await registrarProductos(publicacion)
      res.send("Producto creado con éxito")
    } catch (error) {
      res.status(500).send(error)
    }
  }
  )
//select publicaciones totales
app.get("/publicaciones", async (req, res) => {
    try {
        const rows = await obtenerPublicaciones()
        res.send(rows)
    } catch (error) {
        res.status(500).send(error)
    }
}
)
//select productos detalle
app.get("/productos/:id", async (req, res) => {
    try {
      const { id } = req.params
      const rows = await obtenerProductosId(id)
      res.send(rows)
    } catch (error) {
      res.status(500).send(error)
    }
  }
  )
// obtener las publicaciones de un usuario
  app.get("/usuario/publicaciones", reporteConsultas, async (req, res)=>{
    try {
        const Authorization = req.header("Authorization")
        const token = Authorization.split("Bearer ")[1]
        jwt.verify(token, params)
        const { email } = jwt.decode(token)
        const usuario = await obtenerPublicacionesUser(email)
        res.send(usuario)
    } catch (error) {
        res.status(500).send(error)
        console.log(error);
    }
     
    
})


app.post("/addCar",async (req,res)=>{
    try {
        const carro = req.body
        await agregarCarro(carro)
        res.send("Agregado al carro con exito...")
    } catch (error) {
        res.status(500).send(error)
        console.log(error);
    }
})

app.post("/comprar", async (req,res)=>{
    try {
        const Authorization = req.header("Authorization")
        const datosCompra = req.body
        const token = Authorization.split("Bearer ")[1]
        jwt.verify(token, params)
        const { email } = jwt.decode(token)
        await comprar(email,datosCompra)
        if (comprar) res.status(200).send(`Compra realizada`)
        else res.status(404).send({ message: "No se encontró ninguna compra" })
    } catch (error) {
        res.status(500).send(error)
        console.log(error);
    }
})

//seleccionar compras de un usuario
app.get("/compras", async (req, res) => {
    try {
      const Authorization = req.header("Authorization")
      const token = Authorization.split("Bearer ")[1]
      jwt.verify(token, params)
      const { email } = jwt.decode(token)
      const rows = await obtenerCompras(email)
      res.status(200).send(rows)
    } catch (error) {
      res.status(500).send(error)
    }
  }
)

app.put("/descontar/:id", async (req, res)=>{
    try {
        const { id } = req.params
        const Authorization = req.header("Authorization")
        const token = Authorization.split("Bearer ")[1]
        jwt.verify(token, params)
        await descontar(id)
        res.send(`Se desconto un elemento del carro`)
    } catch (error) {
        res.status(500).send(error)
        console.log(error);
    }
})

app.put("/incrementar/:id", async (req, res)=>{
    try {
        const { id } = req.params
        const Authorization = req.header("Authorization")
        const token = Authorization.split("Bearer ")[1]
        jwt.verify(token, params)
        await incrementar(id)
        res.send(`Se aumento un elemento del carro`)
    } catch (error) {
        res.status(500).send(error)
        console.log(error);
    }
})

app.delete("/deletecar/:id", async (req,res)=>{
    try {
        const { id } = req.params
        const Authorization = req.header("Authorization")
        const token = Authorization.split("Bearer ")[1]
        jwt.verify(token, params)
        await borrarcarro(id)
        res.send(`Se elimino elemento del carro`)
    } catch (error) {
        res.status(500).send(error)
        console.log(error);
    }
})