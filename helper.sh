#!/bin/bash

# Interactive Modal - Helper Script
# Este script facilita las tareas comunes de desarrollo

YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}================================${NC}"
echo -e "${GREEN}Interactive Modal Package Helper${NC}"
echo -e "${GREEN}================================${NC}"
echo ""

show_menu() {
    echo "Selecciona una opción:"
    echo ""
    echo "1. 📦 Instalar dependencias"
    echo "2. 🧪 Ejecutar tests"
    echo "3. 🔍 Analizar código"
    echo "4. 🎨 Formatear código"
    echo "5. 🚀 Ejecutar ejemplo (Travel Map)"
    echo "6. 📝 Ejecutar ejemplo simple"
    echo "7. ✅ Pre-publicación (test + analyze + format)"
    echo "8. 🌐 Dry run de publicación"
    echo "9. 📤 Publicar a pub.dev"
    echo "10. 🔄 Limpiar proyecto"
    echo "0. ❌ Salir"
    echo ""
}

install_deps() {
    echo -e "${YELLOW}📦 Instalando dependencias...${NC}"
    flutter pub get
    cd example && flutter pub get && cd ..
    echo -e "${GREEN}✓ Dependencias instaladas${NC}"
}

run_tests() {
    echo -e "${YELLOW}🧪 Ejecutando tests...${NC}"
    flutter test
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ Tests pasaron exitosamente${NC}"
    else
        echo -e "${RED}✗ Tests fallaron${NC}"
    fi
}

analyze_code() {
    echo -e "${YELLOW}🔍 Analizando código...${NC}"
    flutter analyze
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ Análisis completado sin problemas${NC}"
    else
        echo -e "${RED}✗ Se encontraron problemas${NC}"
    fi
}

format_code() {
    echo -e "${YELLOW}🎨 Formateando código...${NC}"
    dart format .
    echo -e "${GREEN}✓ Código formateado${NC}"
}

run_example() {
    echo -e "${YELLOW}🚀 Ejecutando ejemplo (Travel Map)...${NC}"
    cd example
    flutter run
    cd ..
}

run_simple_example() {
    echo -e "${YELLOW}📝 Para ejecutar el ejemplo simple:${NC}"
    echo ""
    echo "1. Abre example/lib/main.dart"
    echo "2. Cambia el import a: import 'simple_example.dart' as simple;"
    echo "3. Cambia main() para llamar a: simple.main();"
    echo "4. Ejecuta: cd example && flutter run"
    echo ""
}

pre_publish() {
    echo -e "${YELLOW}✅ Ejecutando verificaciones pre-publicación...${NC}"
    echo ""
    
    echo "1/4 - Tests..."
    flutter test
    if [ $? -ne 0 ]; then
        echo -e "${RED}✗ Tests fallaron. Arregla los errores antes de continuar.${NC}"
        return 1
    fi
    
    echo "2/4 - Análisis..."
    flutter analyze
    if [ $? -ne 0 ]; then
        echo -e "${RED}✗ Análisis falló. Arregla los problemas antes de continuar.${NC}"
        return 1
    fi
    
    echo "3/4 - Formato..."
    dart format .
    
    echo "4/4 - Verificando pub points..."
    flutter pub publish --dry-run
    
    echo ""
    echo -e "${GREEN}✓ Verificaciones completadas${NC}"
}

dry_run_publish() {
    echo -e "${YELLOW}🌐 Ejecutando dry run de publicación...${NC}"
    flutter pub publish --dry-run
}

publish_package() {
    echo -e "${YELLOW}📤 Publicando a pub.dev...${NC}"
    echo ""
    echo -e "${RED}ADVERTENCIA: Esto publicará el paquete a pub.dev${NC}"
    echo "¿Estás seguro? (s/n)"
    read -r response
    if [[ "$response" =~ ^([sS][iI]|[sS])$ ]]; then
        flutter pub publish
    else
        echo "Publicación cancelada"
    fi
}

clean_project() {
    echo -e "${YELLOW}🔄 Limpiando proyecto...${NC}"
    flutter clean
    cd example && flutter clean && cd ..
    rm -rf .dart_tool
    rm -rf example/.dart_tool
    echo -e "${GREEN}✓ Proyecto limpiado${NC}"
}

# Menú principal
while true; do
    show_menu
    read -p "Opción: " choice
    echo ""
    
    case $choice in
        1) install_deps ;;
        2) run_tests ;;
        3) analyze_code ;;
        4) format_code ;;
        5) run_example ;;
        6) run_simple_example ;;
        7) pre_publish ;;
        8) dry_run_publish ;;
        9) publish_package ;;
        10) clean_project ;;
        0) 
            echo -e "${GREEN}¡Hasta luego! 👋${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Opción inválida${NC}"
            ;;
    esac
    
    echo ""
    echo -e "${YELLOW}Presiona Enter para continuar...${NC}"
    read
    clear
done
