package aed;

public class triplaDHondt implements Comparable<triplaDHondt> {
        private int idPartido;
        private int cantVotos;
        private int indiceDHondt;
        triplaDHondt(int idPartido, int cantVotos, int indiceDHondt){this.idPartido = idPartido; this.cantVotos = cantVotos; this.indiceDHondt = indiceDHondt;}
        public int partido(){return idPartido;}
        public int votos(){return cantVotos;}
        public int indice(){return indiceDHondt;}

        public triplaDHondt(triplaDHondt otra) {
            idPartido = otra.idPartido;
            cantVotos = otra.cantVotos;
            indiceDHondt = otra.indiceDHondt;
        }

        public void AumentarIndice() {
            cantVotos = ( cantVotos * indiceDHondt ) / (indiceDHondt + 1);

            indiceDHondt = indiceDHondt + 1; 
        }

        @Override
        public int compareTo(triplaDHondt t) {
            int res;
            if (cantVotos < t.votos()) {
                res = -1;
            } else {

                if(cantVotos > t.votos()) {
                    res = 1;

                } else {
                    res = 0;
                }
            }

            return res;

        }
    }
