#!/usr/bin/env bash

### MAIN MENU ###
function menu {
    COLOR='\033[1;34m'
    RED='\033[0;31m'
    NC='\033[0m' # No Color
    options=("Accéder à un dossier" "Quitter")
    optionsAcces=("Ouvrir un fichier" "Renommer un fichier" "Copier un fichier" "Supprimer un fichier" "Chercher un terme dans un fichier" "Créer un dossier" "Ouvrir un dossier" "Renommer un dossier" "Supprimer un dossier" "Afficher une image" "Retour au dossier précédent" "Retour au menu principal" "Quitter") 
    echo -e "${COLOR}Sélectionnez une action ${NC}"
    select responseAction in "${options[@]}";do
        case ${responseAction} in
            "Accéder à un dossier" ) choiceAction="allerDossier";break;;
            Quitter ) choiceAction="Quitter";break;;
        esac
    done
    
    #Quitter
    if [ "$choiceAction" == "Quitter" ]
    then
        echo "A bientôt"
        exit;
    fi
  
### ACCEDER A UN DOSSIER ###
    
    # MENU ACCES
    function sousmenuAcces {
    COLOR='\033[1;34m'
    GREEN='\033[1;32m'
    NC='\033[0m' # No Color
        echo -e "${GREEN}Vous êtes ici :${NC}"
        pwd
        echo -e "${GREEN}Contenu du dossier :${NC}"
        ls
        echo -e "${COLOR}Que voulez-vous faire ? ${NC}"
        select responseAcces in "${optionsAcces[@]}";do
            case ${responseAcces} in
                "Ouvrir un fichier" ) choiceAcces="ouvrirFichier";break;;
                "Renommer un fichier" ) choiceAcces="renommerFichier";break;;
                "Copier un fichier" ) choiceAcces="copierFichier";break;;
                "Supprimer un fichier" ) choiceAcces="supprimerFichier";break;;
                "Chercher un terme dans un fichier" ) choiceAcces="chercherDansFichier";break;;
                "Créer un dossier" ) choiceAcces="creerDossier";break;;
                "Ouvrir un dossier" ) choiceAcces="ouvrirDossier";break;;
                "Renommer un dossier" ) choiceAcces="renommerDossier";break;;
                "Supprimer un dossier" ) choiceAcces="supprimerDossier";break;;
                "Afficher une image" ) choiceAcces="afficherImage";break;;
                "Retour au dossier précédent" ) choiceAcces="retourDossier";break;;
                "Retour au menu principal" ) choiceAcces="Retour";break;;
                Quitter ) choiceAcces="Quitter";break;;
            esac
        done
        
        #Ouvrir un fichier
        if [ "$choiceAcces" == "ouvrirFichier" ]
        then
            echo -e "${COLOR}Tous les fichiers disponibles : ${NC}"
            ## EXCLURE IMAGES ##
            find . -not -name "*.gif" -not -name "*.jpg" -not -name "*.png" -type f
            echo -e "${COLOR}Nom du fichier auquel vous souhaitez accéder : ${NC}"
            read -e nomFichier
            echo -e "${GREEN}Contenu du fichier :${NC}"
            cat $nomFichier
            sousmenuAcces
        fi
        
        #Renommer un fichier
        if [ "$choiceAcces" == "renommerFichier" ]
        then
            echo -e "${COLOR}Tous les fichiers disponibles :${NC}"
            ## EXCLURE IMAGES ##
            find . -not -name "*.gif" -not -name "*.jpg" -not -name "*.png" -type f
            echo -e "${COLOR}Nom actuel du fichier que vous souhaitez renommer :${NC}"
            read -e nomActuelFichier
            echo -e "${COLOR}Nouveau nom pour ce fichier :${NC}"
            read -e nouveauNomFichier
            echo -e "${COLOR}Souhaitez vous renommer $nomActuelFichier en $nouveauNomFichier ? (O/n)${NC}"  
            read -e responseRename
                if [ "$responseRename" == "O" ]
                then
                    mv $nomActuelFichier $nouveauNomFichier
                    echo -e "${GREEN}Le fichier a bien été renommé ${NC}"
                    ls -al | grep '^-'
                else 
                  sousmenuAcces
                fi
            sousmenuAcces
        fi
        
         #Chercher dans un fichier
        if [ "$choiceAcces" == "chercherDansFichier" ]
        then
            echo -e "${COLOR}Tous les fichiers disponibles : ${NC}"
            ## EXCLURE IMAGES ##
            find . -not -name "*.gif" -not -name "*.jpg" -not -name "*.png" -type f
            echo -e "${COLOR}Terme que vous souhaitez rechercher dans les fichiers : ${NC}"
            read -e research
            find . -type f -print | xargs grep "$research"
            sousmenuAcces
        fi
        
        
         #Supprimer un fichier
        if [ "$choiceAcces" == "supprimerFichier" ]
        then
            echo -e "${COLOR}Tous les fichiers disponibles : ${NC}"
            ls -al | grep '^-'
            echo -e "${COLOR}Nom du fichier que vous souhaitez supprimer : ${NC}"
            read -e nomFichier
            echo -e "${COLOR}Êtes vous sûr de vouloir supprimer $nomFichier ? (O/n) ${NC}"
            read -e responseDelete
                if [ "$responseDelete" == "O" ]
                then
                    rm $nomFichier
                    echo -e "${GREEN}Le fichier a bien été supprimé ${NC}"
                    ls -al | grep '^-'
                else 
                  sousmenuAcces
                fi
            sousmenuAcces
        fi
        
          #Copier un fichier
        if [ "$choiceAcces" == "copierFichier" ]
        then
            echo -e "${COLOR}Tous les fichiers disponibles :${NC}"
            ls -al | grep '^-'
            echo -e "${COLOR}Nom actuel du fichier que vous souhaitez copier :${NC}"
            read -e nomFichier
            cp $nomFichier $nomFichier."copie"
            echo -e "${GREEN}Le fichier a bien été copié${NC}"
            ls -al | grep '^-'
            sousmenuAcces
        fi
    
        #Créer un dossier
        if [ "$choiceAcces" == "creerDossier" ]
        then
            echo -e "${COLOR}Tous les dossiers disponibles :${NC}"
            find [0-9a-zA-Z]* -type d
            echo -e "${COLOR}Nouveau nom pour le dossier que vous souhaitez ajouter :${NC}"
            read -e nomDossier
            mkdir $nomDossier
            echo -e "${GREEN}Le dossier $nomdudossier a bien été créé${NC}"
            ls
            sousmenuAcces
        fi
        
        #Ouvrir un dossier
        if [ "$choiceAcces" == "ouvrirDossier" ]
        then
            echo -e "${COLOR}Tous les dossiers disponibles :${NC}"
            find [0-9a-zA-Z]* -type d
            echo -e "${COLOR}Nom du dossier auquel vous souhaitez accéder :${NC}"
            read -e nomDossier
            cd $nomDossier/
            sousmenuAcces
        fi
         #Ouvrir une image
        if [ "$choiceAcces" == "afficherImage" ]
        then
            echo -e "${COLOR}Toutes les images disponibles :${NC}"
            find . -type f -exec file {} \; | awk -F: '{if ($2 ~/image/) print $1}'
            echo -e "${COLOR}Nom de l'image que vous souhaitez ouvrir :${NC}"
            read -e nomImage
            xdg-open $nomImage/
            sousmenuAcces
        fi
        #Supprimer un fichier
        if [ "$choiceAcces" == "supprimerDossier" ]
        then
            echo -e "${COLOR}Tous les dossier disponibles : ${NC}"
            find [0-9a-zA-Z]* -type d
            echo -e "${COLOR}Nom du dossier que vous souhaitez supprimer : ${NC}"
            read -e nomDossier
            echo -e "${COLOR}Êtes vous sûr de vouloir supprimer $nomDossier ? (O/n) ${NC}"
            read -e responseDelete
                if [ "$responseDelete" == "O" ]
                then
                    rm -rf $nomDossier
                    echo -e "${GREEN}Le dossier a bien été supprimé ${NC}"
                   find [0-9a-zA-Z]* -type d
                else 
                  sousmenuAcces
                fi
            sousmenuAcces
        fi
        #Renommer un dossier
        if [ "$choiceAcces" == "renommerDossier" ]
        then
            echo -e "${COLOR}Tous les dossiers disponibles :${NC}"
            find [0-9a-zA-Z]* -type d
            echo -e "${COLOR}Nom actuel du dossier que vous souhaitez renommer :${NC}"
            read -e nomActuelDossier
            echo -e "${COLOR}Nouveau nom pour ce dossier :${NC}"
            read -e nouveauNomDossier
            echo -e "${COLOR}Souhaitez vous renommer $nomActuelDossier en $nouveauNomDossier ? (O/n)${NC}"  
            read -e responseRename
                if [ "$responseRename" == "O" ]
                    then
                        mv $nomActuelDossier $nouveauNomDossier
                        echo -e "${GREEN}Le dossier a bien été renommé ${NC}"
                        find [0-9a-zA-Z]* -type d
                    else 
                    sousmenuAcces
                fi
                sousmenuAcces
        fi
         #RetourDossier
        if [ "$choiceAcces" == "retourDossier" ]
        then
         echo -e "${COLOR}Souhaitez vous retourner dans le dossier précédent ? (O/n) ${NC}"
            read -e responseMove
                if [ "$responseMove" == "O" ]
                then
                    cd ~- ## UNE SEULE FOIS - A CORRIGER ##
                else 
                  sousmenuAcces
                fi
        fi
        sousmenuAcces
        
        #Retour
        if [ "$choiceAcces" == "Retour" ]
        then
            reset
            menu
        fi
        #Quitter
        if [ "$choiceAcces" == "Quitter" ]
        then
            echo -e "${GREEN}A bientôt${NC}"
            exit;
        fi
        sousmenuAcces
        
        #Quitter
        if [ "$choiceAcces" == "Quitter" ]
        then
            echo -e "${GREEN}A bientôt${NC}"
            exit;
        fi
        }
        sousmenuAcces
        

    if [ "$choiceAction" == "allerDossier" ]
    then
        echo -e "${COLOR}Vous êtes ici :${NC}"
        pwd
        echo -e "${COLOR}Tous les dossiers disponibles :${NC}"
        find [0-9a-zA-Z]* -type d
        echo -e "${COLOR}Nom du dossier auquel vous souhaitez accéder :${NC}"
        read -e nomDossier
        cd $nomDossier
        sousmenuAcces
    fi
}
menu