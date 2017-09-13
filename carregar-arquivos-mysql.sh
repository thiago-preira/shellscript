#!/bin/bash
#Atividades:
#1- Varrer o diretório procurando arquivos csv
#2- Ler o arquivo 
#3- Realizar o insert das linhas
# primeiro parametro deve ser o host do mysql
# segundo parametro deve ser o usuario do mysql
# terceiro parametro deve ser a senha do usuario
MYSQL_HOST=$1
MYSQL_USER=$2
MYSQL_PWD=$3
insert_into_mysql(){
   local query="INSERT INTO sales.items_sold (date,description,total,imported_filename) VALUES '$1',$2,$3,'$4');"
   mysql -h$MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PWD -e"$query"
   if [ $? -ne 0 ]
   then
      echo "Erro executando query: $query" > logs/errors.txt
   fi
}
read_file_content(){
  local file_name=$1
  sed 1d $1 | while IFS='\n' read line
  do
    echo $line | while IFS=';' read DATA DESCRICAO TOTAL
    do
      insert_into_mysql $DATA "$DESCRICAO" $TOTAL $file_name
    done
  done
}
read_files(){
  shopt -s nullglob
  for arquivo in *.csv
  do
   read_file_content $arquivo
  done
}
if [ ! -d logs ]
then
  mkdir logs
fi

read_files
