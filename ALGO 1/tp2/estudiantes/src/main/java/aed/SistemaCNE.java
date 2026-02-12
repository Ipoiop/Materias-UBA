package aed;
public class SistemaCNE {
    private DictAcotado<Integer, String> nombresPartidos;
    private DictAcotado<Integer, String> nombresDistritos;
    private DictAcotado<Integer, Integer> diputadosDeDistritos;
    private DictAcotado<Integer, rangoMesas> rangoMesasDistritos;
    private DictAcotado<Integer, Integer> votosPresidenciales;
    private DictAcotado<Integer, DictAcotado<Integer, Integer>> votosDiputados;
    private ListaEnlazada<Integer> mesasRegistradas;
    private int maximo1Presidente;
    private int maximo2Presidente;
    private int totalVotosPresidente;
    private int cantPartidos;
    private DictAcotado<Integer, Heap<triplaDHondt>> votosDiputadosDHondt;

    public class VotosPartido{
        private int presidente;
        private int diputados;
        VotosPartido(int presidente, int diputados){this.presidente = presidente; this.diputados = diputados;}
        public int votosPresidente(){return presidente;}
        public int votosDiputados(){return diputados;}
    }

    public class rangoMesas{
        private int desde;
        private int hasta;
        rangoMesas(int desde, int hasta){this.desde = desde; this.hasta = hasta;}
        public int rangoDesde(){return desde;}
        public int rangoHasta(){return hasta;}
    }

    public SistemaCNE(String[] nombresDistritos/*/ */, int[] diputadosPorDistrito/* */, String[] nombresPartidos/* */, int[] ultimasMesasDistritos) {
        this.nombresDistritos = new DictAcotado<>(nombresDistritos.length);
        this.nombresPartidos = new DictAcotado<>(nombresPartidos.length);
        this.diputadosDeDistritos = new DictAcotado<>(diputadosPorDistrito.length);
        this.rangoMesasDistritos = new DictAcotado<>(ultimasMesasDistritos.length);
        this.votosPresidenciales = new DictAcotado<>(nombresPartidos.length);
        this.votosDiputados = new DictAcotado<>(nombresDistritos.length);
        this.mesasRegistradas = new ListaEnlazada<>();
        this.cantPartidos = -1; //En -1 porque cuando haga el for de los nombres de los partidos, el ultimo elem son los votos en blanco y no me interesan


        
        for(int i = 0; i<nombresDistritos.length; i++){//O(D)
            this.nombresDistritos.definir(i, nombresDistritos[i]);
        }

        for(int i = 0; i<nombresPartidos.length; i++){//O(P)
            this.nombresPartidos.definir(i, nombresPartidos[i]);
            cantPartidos = cantPartidos + 1;
        }

        for(int i = 0; i<diputadosPorDistrito.length; i++){//O(D)
            this.diputadosDeDistritos.definir(i, diputadosPorDistrito[i]);
        }

        for(int i = 0; i<nombresPartidos.length; i++){//O(P)
            this.votosPresidenciales.definir(i, 0);
        }

        for(int i = 0; i<nombresDistritos.length; i++){//O(P*D)
            this.votosDiputados.definir(i, new DictAcotado<>(nombresPartidos.length));
            for(int j = 0; j<nombresPartidos.length; j++){
                this.votosDiputados.obtener(i).definir(j, 0);
            }
        }

        for(int i = 0; i<ultimasMesasDistritos.length; i++){//O(D)
            if(i==0){
                this.rangoMesasDistritos.definir(i, new rangoMesas(0, ultimasMesasDistritos[0]));
            }else{
                this.rangoMesasDistritos.definir(i, new rangoMesas(ultimasMesasDistritos[i-1], ultimasMesasDistritos[i]));
            }
        }
    }

    public String nombrePartido(int idPartido) {
        return nombresPartidos.obtener(idPartido);
    }

    public String nombreDistrito(int idDistrito) {
        return nombresDistritos.obtener(idDistrito);
    }

    public int diputadosEnDisputa(int idDistrito) {
        int res;
        res = diputadosDeDistritos.obtener(idDistrito);

        return res;
    }

    public String distritoDeMesa(int idMesa) {//o(lg(D))
        int low = 0;
        int high = rangoMesasDistritos.tamaño() -1;

        //casos triviales
        if(rangoMesasDistritos.obtener(0).hasta > idMesa){
            return nombresDistritos.obtener(0);
        }else{
            if(rangoMesasDistritos.obtener(high).desde <= idMesa){
                return nombresDistritos.obtener(high);//sino cual?
            }else{
                //casos no triviales
                while(low+1 < high){ // Este while deja dos posibles opciones
                    int mid = (high+low)/2;
                    if(rangoMesasDistritos.obtener(mid).hasta <= idMesa){
                        low = mid;
                    }else{
                        high = mid;
                    }
                }
            }
        }
        if(rangoMesasDistritos.obtener(low).hasta <= idMesa) { // Decide con cual de las dos opciones quedarse
            low = high;
        }

        return nombresDistritos.obtener(low);
    }


    public void registrarMesa(int idMesa, VotosPartido[] actaMesa) {
        int idDistr = distritoDeMesaID(idMesa); //o(lg(D))
        triplaDHondt[] arrayVotosDipDistrito = new triplaDHondt[cantPartidos]; //El array que luego vamos a heapifiar

        for (int i = 0; i < actaMesa.length; i++){ //o(P)
            //presidente
            votosPresidenciales.definir(i, votosPresidenciales.obtener(i) + actaMesa[i].presidente);
            totalVotosPresidente = totalVotosPresidente + actaMesa[i].presidente;
            if(maximo1Presidente < votosPresidenciales.obtener(i) && i < actaMesa.length -1){
                maximo2Presidente = maximo1Presidente;
                maximo1Presidente = votosPresidenciales.obtener(i);
            }else{
                if(votosPresidenciales.obtener(i) < maximo1Presidente && maximo2Presidente < votosPresidenciales.obtener(i) && i < actaMesa.length -1){
                    maximo2Presidente = votosPresidenciales.obtener(i);
                }
            }

            //diputados
            votosDiputados.obtener(idDistr).definir(i, votosDiputados.obtener(idDistr).obtener(i) + actaMesa[i].diputados);

            //Me creo el array de triplas que vamos a heapifiar
            if (i != actaMesa.length-1) { //Porque no me interesa registrar los votos en blanco
                triplaDHondt tripla = new triplaDHondt(i, votosDiputados.obtener(idDistr).obtener(i), 1);
                arrayVotosDipDistrito[i] = tripla;
            }
        }
        //mesas
        mesasRegistradas.agregar(idMesa);

        //Aca se heapifiaria el array arrayVotosDipDistrito cuando lo terminemos
        
    }

    private int distritoDeMesaID(int idMesa) { // Funcion auxiliar igual a distritoDeMesa pero que devuelve la ID
        int low = 0;
        int high = rangoMesasDistritos.tamaño() -1;

        //casos triviales
        if(rangoMesasDistritos.obtener(0).hasta > idMesa){
            return low;
        }else{
            if(rangoMesasDistritos.obtener(high).desde <= idMesa){
                return high;//sino cual?
            }else{
                //casos no triviales
                while(low+1 < high){ // Este while deja dos posibles opciones
                    int mid = (high+low)/2;
                    if(rangoMesasDistritos.obtener(mid).hasta <= idMesa){
                        low = mid;
                    }else{
                        high = mid;
                    }
                }
            }
        }
        if(rangoMesasDistritos.obtener(low).hasta <= idMesa) { // Decide con cual de las dos opciones quedarse
            low = high;
        }

        return low;

    }

    public int votosPresidenciales(int idPartido) {
        return votosPresidenciales.obtener(idPartido);
    }

    public int votosDiputados(int idPartido, int idDistrito) {
        return votosDiputados.obtener(idDistrito).obtener(idPartido);
    }

    public int[] resultadosDiputados(int idDistrito){ 
        int[] res = new int[cantPartidos]; //Ya te lo inicializa en 0 de base

        for(int i = 0; i < diputadosEnDisputa(idDistrito); i++) {
            triplaDHondt Max = new triplaDHondt(votosDiputadosDHondt.obtener(idDistrito).maximo()); //La tripla del maximo
            res[Max.partido()] = res[Max.partido()] + 1; //Le voy sumando las bancas que van obteniendo cada partido

            Max.AumentarIndice(); //Aumento el indice y se lo cambio al heap 
            votosDiputadosDHondt.obtener(idDistrito).cambiarValorMaximo(Max);
        }

        return res;
    }

    public boolean hayBallotage(){
        boolean res;
        res = auxBallotage(this.maximo1Presidente, this.maximo2Presidente, this.totalVotosPresidente);
        return res;
    }

    private boolean auxBallotage(int maximo1, int maximo2, int totalVotos){//los votos de max1 y 2 se sabe que no son en blanco 
        int porcenMax1 = auxiliarPorcentaje(maximo1, totalVotos);
        int porcenMax2 = auxiliarPorcentaje(maximo2, totalVotos);

        if(porcenMax1>=45) {return false;} //alcanza con fijarse en el mayor, pq si max2 superase el 45 si o si el max1 tmb
        else {//mas de 40 con 10 de diff
            if(porcenMax1 >=40 && porcenMax2 < porcenMax1 -10) {
                return false;
            }else{return true;}
        }
    }

    private int auxiliarPorcentaje(int valor, int totalVotos) {
        if(totalVotos!=0) return ((valor*100)/totalVotos);//Si bien no nos van a pasar cantVotos = 0, pongo el if por precaución.
        else return 0;
    }

    /*private double modulo(double valor){
        if (valor>=0) return valor;
        else return -valor;
    }*/
}

