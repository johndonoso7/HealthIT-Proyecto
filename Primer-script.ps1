# Script de ejemplo Health IT
# Crea carpetas para pacientes y HL7
mkdir Pacientes
mkdir HL7

# Crear archivo de paciente simulado
echo "Nombre: Juan Carlos Pérez" > Pacientes/paciente1.txt
echo "Edad: 33" >> Pacientes/paciente1.txt
echo "Estudio: RX de torax" >> Pacientes/paciente1.txt
echo "Genero: Masculino" >> Pacientes/paciente1.txt

# Crear archivo HL7 simulado
echo "MSH|^~\&|HOSPITAL|123|LAB|456|20250927||ADT^A01|0001|P|2.5" > HL7/mensaje1.hl7
echo "PID|1||12345||Pérez^Juan||19891010|M" >> HL7/mensaje1.hl7

Write-Host "¡Script ejecutado correctamente!"