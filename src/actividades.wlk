import socios.*

class Viaje {
    const property idiomas = new Set()
    
    method esViajeinteresante() = idiomas.size() > 1
    method implicaEsfuerzo()
    method sirveParaBroncear()
    method cantDiasDeActividad() = pandemia.diasDeCuarentena()
    method esRecomendadaParaSocio(unSocio) = self.esViajeinteresante() and unSocio.leAtraeActividad(self) and not unSocio.actividades().contains(self)
}

class ViajeDePlaya inherits Viaje {
    const largoPlaya

    override method implicaEsfuerzo() = largoPlaya > 1200
    override method sirveParaBroncear() = true
    override method cantDiasDeActividad() = largoPlaya / 500 + super()
}

class ExcursionCiudad inherits Viaje {
    var property cantAtraccionesAVisitar

    override method esViajeinteresante() = super() or cantAtraccionesAVisitar == 5
    override method implicaEsfuerzo() = cantAtraccionesAVisitar.between(5,8)
    override method sirveParaBroncear() = false
    override method cantDiasDeActividad() = cantAtraccionesAVisitar / 2 + super()
}

class ExcursionCiudadTropical inherits ExcursionCiudad{

    override method sirveParaBroncear() = true
    override method cantDiasDeActividad() = super() + 1 + super()
}

class SalidaTrekking inherits Viaje {
    const cantKmsDeSenderos
    const cantDiasDeSolPorAnio

    override method esViajeinteresante() = super() and cantDiasDeSolPorAnio > 140
    override method implicaEsfuerzo() = cantKmsDeSenderos > 80
    override method sirveParaBroncear() = cantDiasDeSolPorAnio > 200 or (cantDiasDeSolPorAnio.between(100,200) and cantKmsDeSenderos > 120)
    override method cantDiasDeActividad() = cantKmsDeSenderos / 50 + super()
}

// para terminar de comprender en que casos usamos un objeto que puede modificar 
// comportamiento o mensajes de todas las instancias de una clase, suponemos que al modelo de Viajes
// se agrega una complejidad más que hace que a todos los tipos de viaje se le sume una cantidad de días
// configurable cuando se declara pandemia, como dias de cuarentena. Este valor debe afectar a todos los viajes
// por igual y es configurable para una pandemia.

object pandemia {
	var property diasDeCuarentena = 0
}


class Gimnasia {

    method idiomas() = #{"español"}
    method implicaEsfuerzo() = true
    method sirveParaBroncear() = false
    method cantDiasDeActividad() = 1
    method esRecomendadaParaSocio(unSocio) = unSocio.edad().between(20,30)
}

class TallerLiterario{
    const librosEnQueTrabaja = #{}
	
	method idiomas() = librosEnQueTrabaja.map({l => l.idioma()}).asSet()
    method cantDiasDeActividad() = librosEnQueTrabaja.size() + 1
    method tieneLibroConMasDe500Pag() = librosEnQueTrabaja.any({l => l.cantPaginas() > 500})
    method autoresDeLibros() = librosEnQueTrabaja.map({l => l.nombreDelAutor()}).asSet()
    method todosLosLibrosSonDelMismoAutor() = self.autoresDeLibros().size() == 1
    method hayMasDeUnLibro() = librosEnQueTrabaja.size() > 1
    method implicaEsfuerzo() = self.tieneLibroConMasDe500Pag() or (self.todosLosLibrosSonDelMismoAutor() and self.hayMasDeUnLibro())
    method sirveParaBroncear() = false
    method esRecomendadaParaSocio(unSocio) = unSocio.idiomas().size() > 1
}

class Libro{
    const property idioma
    const property cantPaginas
    const property nombreDelAutor
}