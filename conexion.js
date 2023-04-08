const {Pool} = require("pg")
//const pool = require('./config')
const bcrypt = require('bcryptjs')
var LocalStorage = require('node-localstorage').LocalStorage,
localStorage = new LocalStorage('./scratch');
let array =[]

localStorage.setItem('MyArray', JSON.stringify(array));

const pool = new Pool({
    host:     process.env.POSTGRESQL_ADDON_HOST,
    user:     process.env.POSTGRESQL_ADDON_USER,
    password: process.env.POSTGRESQL_ADDON_PASSWORD,
    database: process.env.POSTGRESQL_ADDON_DB,
    port:     process.env.POSTGRESQL_ADDON_PORT,
})
// sesscion consultas usuarios
const login = async(email,password)=>{
    const values = [email]   
    const consulta = "select id, rut, email, nombre, password from usuarios where email=$1"
    const result = await pool.query(consulta,values)   
    const  { rows:[usuario], rowCount } = result
    const { password: passwordEncriptada } = usuario
    const passwordCorrecta = bcrypt.compareSync(password,passwordEncriptada)
    if (!passwordCorrecta || !rowCount) {
        throw { code: 401, message:"Email o PassWord incorrecto..."}
    } 
    return usuario   
}

const registrarUsuario = async (usuario)=>{
    let { rut,email,nombre,password } = usuario
    const pwBcrypt = bcrypt.hashSync(password)
    passwd = pwBcrypt
    const values = [rut,email,nombre,passwd]
    console.log(values);
    const consulta = "INSERT INTO usuarios (id,rut,email,nombre,password) values (DEFAULT, $1, $2, $3, $4)"
    await pool.query(consulta, values)
}
// esta funcion que obtiene los datos del usuario logueado.
const obtenerUsuario = async (email)=>{
    const values = [email]   
    const consulta = "select * from usuarios where email=$1"
    const { rows } = await pool.query(consulta,values)    
    return rows
}

// funcion para modificar el usuario
const modificarUsuario = async (usuario,id) => {
    let { nombre,direccion,telefono,password} = usuario
    const pwBcrypt = bcrypt.hashSync(password)
    passwd = pwBcrypt
    const values = [id,nombre,direccion,telefono,passwd]
    const consulta = "UPDATE usuarios	SET nombre=$2, direccion=$3, telefono=$4, password=$5 WHERE id=$1"
    const result = await pool.query(consulta, values)
    }

// seccion publicaciones
/** productos* */
const registrarProductos = async (producto) => {
    let { usuario_id,titulo, precio,stock,categoria_id, descripcion,imagen1 } = producto
    const values = [usuario_id, titulo, precio, descripcion, stock, categoria_id, imagen1]
    const consulta = "INSERT INTO publicaciones (id,usuario_id,titulo,precio,descripcion,stock,categoria_id,imagen1) values (DEFAULT,$1,$2,$3,$4,$5,$6,$7)"
    await pool.query(consulta, values)
  }
const obtenerProductosId = async (id) => {
    let values = [id]
    const consulta = "SELECT * FROM publicaciones WHERE id = $1"
    const { rows } = await pool.query(consulta, values)
    return rows
  }

  const obtenerPublicaciones = async () => {
    const { rows } = await pool.query("SELECT * FROM publicaciones")
    return rows
}

const obtenerPublicacionesUser = async (email) => {
    const value = [email]   
    const consultaId = "select * from usuarios where email=$1"
    const  user = await pool.query(consultaId,value) 
    const values = [user.rows[0].id]
    const consulta ="SELECT id, usuario_id, titulo, precio, descripcion, stock, categoria_id, imagen1, imagen2, imagen3, estado_id,substring(date_creacion::text, 1,10) as fecha FROM publicaciones WHERE usuario_id=$1 ORDER BY id"
    const { rows } = await pool.query(consulta, values)  
    return rows
    //
}

// Seccion de consultas para la comprar y agregar al carro
const insertarDetalle = async(publicacion_id, cantidad, precio,item,codigo)=>{ //este detalle corresponde a la boleta de la compra
    const values =[publicacion_id, cantidad, precio,item,codigo]
    const queryIn = "INSERT INTO detalleorden (id, publicacion_id, cantidad, precio, item, orden_id) VALUES (DEFAULT, $1, $2, $3, $4, $5)"
    await pool.query(queryIn,values)
    const updateStock = "UPDATE publicaciones SET stock=stock-$2 WHERE id=$1"
    const value = [publicacion_id, cantidad]
    await pool.query(updateStock,value)
    console.log(`Item fue agregado y editado correctamente`);
       
}

const comprar = async (email,datosCompra)=>{
    const value = [email]
    const query = "select id,concat(extract(month from current_date),extract(day from current_date),id, trunc(random() * 99 + 13)) as codigo from usuarios where email = $1"
    const usuario_id = await pool.query(query,value)
    let id = usuario_id.rows[0].id
    let orden_id = usuario_id.rows[0].codigo
    let item = 1
    let total = 0
    datosCompra.map((e) => {
        insertarDetalle(e.id, 1, e.price, item, orden_id)
        item++;
        total += (e.price * 1)
    });

    const values =[id,total,orden_id]
    const InsertOrden = "INSERT INTO ordenes (id, usuario_id, total, orden_id) VALUES (DEFAULT, $1 ,$2, $3)"
    await pool.query(InsertOrden, values)
    console.log("Compra agregada con exito");
}

const obtenerCompras = async (email) => {
    const value = [email]
    const query = "select id from usuarios where email = $1"
    const usuario_id = await pool.query(query, value)
    let id = usuario_id.rows[0].id
    let values = [id]
    const consulta = 
    `SELECT c.id,b.titulo,b.precio,b.imagen1 FROM ordenes AS c 
    LEFT JOIN detalleOrden a ON a.orden_id = c.orden_id
    LEFT JOIN publicaciones b ON b.id = a.publicacion_id 
    WHERE c.usuario_id = $1 AND b.titulo <> '' ORDER BY c.id ASC`
    const { rows } = await pool.query(consulta, values)
    return rows
  }

const agregarCarro = async (car)=>{
    var array1 = localStorage.myArray
    array = await JSON.parse(array1);
    array.push(car)
    localStorage.setItem('MyArray', JSON.stringify(array));
    console.log(array);

}

const descontar = async (id)=>{
    var array1 = localStorage.myArray
    array = await JSON.parse(array1);
    let array2 = []
    array.forEach(async(e) => {
        if (e.publicacion_id==id) { 
            e.cantidad-=1        
            if (e.cantidad<1) {
                console.log("se elimino el item del carrito");
            } else {                
                array2.push(e)
                console.log("se desconto un item del carrito");
            }            
        } else {
            array2.push(e)
        }
    });
    console.log(array2);
    localStorage.setItem('MyArray', JSON.stringify(array2));
}

const incrementar = async (id)=>{
    var array1 = localStorage.myArray
    array = await JSON.parse(array1);
    let array2 = []
    array.forEach(async(e) => {
        if (e.publicacion_id==id) { 
            e.cantidad+=1        
            array2.push(e)
            console.log("se sumo un item del carrito");                       
        } else {
            array2.push(e)
        }
    });
    localStorage.setItem('MyArray', JSON.stringify(array2));
}
const borrarcarro = async (id)=>{
    var array1 = localStorage.myArray
    array = await JSON.parse(array1);
    let array2 = []
    array.forEach(async(e) => {
        if (e.publicacion_id==id) { 
            console.log("se elimino item del carrito");                       
        } else {
            array2.push(e)
        }
    });
    localStorage.setItem('MyArray', JSON.stringify(array2));
}
module.exports = { login, registrarUsuario, obtenerUsuario, comprar, obtenerPublicaciones,agregarCarro,descontar,incrementar,borrarcarro,modificarUsuario,obtenerProductosId,obtenerCompras,obtenerPublicacionesUser,registrarProductos }
