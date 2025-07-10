#!/bin/bash
source ./scan.lib
echo " "
echo "====================================================================="
cd /home/parrot/Desktop/dirsearch-master || exit
source venv/bin/activate

NOW=$(date)
echo "THE PERFORMED $NOW"

# Default values
INTERACTIVE=false
MODE=""

# Help message early check
for arg in "$@"; do
    if [[ "$arg" == "--help" || "$arg" == "-h" ]]; then
        echo "./recon.sh -i -m [Mode] [Domains...]"
        echo "Modes: "
        echo "  nmap-only      : To perform only Nmap scan"
        echo "  dirsearch-only : To perform only Dirsearch scan"
        echo "  crt-only       : To perform only crt.sh result"
        echo "Options:"
        echo "  -m             : Mode for scanning"
        echo "  -i             : Interactive domain input mode"
        echo "If no mode is entered, all scans will be performed."
        exit 0
    fi
done

# Parse options
while getopts "m:ih" OPTION; do
    case $OPTION in
        m)
            MODE=$OPTARG
            ;;
        i)
            INTERACTIVE=true
            ;;
        h)
            echo "./recon.sh -i -m [Mode] [Domains...]"
            echo "Modes: "
            echo "  nmap-only      : To perform only Nmap scan"
            echo "  dirsearch-only : To perform only Dirsearch scan"
            echo "  crt-only       : To perform only crt.sh result"
            echo "Options:"
            echo "  -m             : Mode for scanning"
            echo "  -i             : Interactive domain input mode"
            echo "If no mode is entered, all scans will be performed."
            exit 0
            ;; 
        *)
            echo "Invalid Option! Please enter valid option for or for help try --help"
            exit 1
            ;;
    esac
done



scan_domain(){
    DOMAIN=$1
    DIRECTORY="${DOMAIN}_recon"
    echo "CREATING DIRECTORY $DIRECTORY..."
    mkdir -p "$DIRECTORY"

    case $MODE in
        nmap-only)
            nmap_scan "$DOMAIN" "$DIRECTORY"
            echo "------------------------------------------------------------------------------"
            ;;
        dirsearch-only)
            dirsearch_scan "$DOMAIN" "$DIRECTORY"
            echo "-------------------------------------------------------------------------------"
            ;;
        crt-only)
            crt_scan "$DOMAIN" "$DIRECTORY"
            echo "--------------------------------------------------------------------------------"
            ;;
        *)
            nmap_scan "$DOMAIN" "$DIRECTORY"
            echo "----------------------------------------------------------------------"
            dirsearch_scan "$DOMAIN" "$DIRECTORY"
            echo "----------------------------------------------------------------------"
            crt_scan "$DOMAIN" "$DIRECTORY"
            echo "-----------------------------------------------------------------------"
            ;;
    esac
}

report_domain(){
    DOMAIN=$1
    DIRECTORY="${DOMAIN}_recon"

    echo "GENERATING RECON REPORT FROM OUTPUT FILE..."
    echo "THIS REPORT CREATED $NOW" >> "$DIRECTORY/Report"
    
    if [ -f "$DIRECTORY/nmap" ]; then
        echo "RESULT FOR nmap:" >> "$DIRECTORY/Report"
        grep -E "^\s*\S+\s+\S+\s+\S+\s*$" "$DIRECTORY/nmap" >> "$DIRECTORY/Report"
    fi

    if [ -f "$DIRECTORY/dirsearch" ]; then
        echo "RESULT FOR dirsearch:" >> "$DIRECTORY/Report"
        cat "$DIRECTORY/dirsearch" >> "$DIRECTORY/Report"
    fi

    if [ -f "$DIRECTORY/crt" ]; then
        echo "RESULT FOR crt.sh:" >> "$DIRECTORY/Report"
        jq -r ".[] | .name_value" "$DIRECTORY/crt" >> "$DIRECTORY/Report"
    fi
}

if $INTERACTIVE; then
    INPUT=""
    while true; do
        echo "Please enter the domain (or type 'quit' to exit):"
        read INPUT
        if [ "$INPUT" = "quit" ]; then
            break
        fi
        scan_domain "$INPUT"
        report_domain "$INPUT"
    done
else
    shift $((OPTIND -1))
    for DOMAIN in "$@"; do
        scan_domain "$DOMAIN"
        report_domain "$DOMAIN"
    done
fi
