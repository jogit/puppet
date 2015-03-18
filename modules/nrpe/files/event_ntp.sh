#!/bin/bash
# Script centreon de remise a l'heure avec ntpdate

NTP_HOSTNAME=$1
SERVICESTATE=$2
SERVICESTATETYPE=$3
SERVICEATTEMPT=$4


action() {
    ntpdate $NTP_HOSTNAME
}


case "$SERVICESTATE" in
    OK)
        # Pas de probleme. On ne fait rien.
        ;;
    WARNING)
        # Warning. On ne fait rien.
        ;;
    UNKNOWN)
        # Etat inconnu. On ne fait rien.
        ;;
    CRITICAL)
        # Etat critique. On ne va lancer ntpdate qu'au deuxieme etat CRITICAL SOFT, ou a l etat HARD.
        case "$SERVICESTATETYPE" in
            SOFT)
                # Verification du nombre de tentatives
                case "$SERVICEATTEMPT" in
                    2)
                        # On lance ntpdate.
                        action
                        ;;
                esac
                ;;
            HARD)
                # On lance ntpdate.
                action
                ;;
        esac
        ;;
esac
