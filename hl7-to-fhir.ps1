# Script: HL7 → FHIR JSON
# Carpeta de entrada HL7 y salida FHIR
$hl7Folder = "HL7"
$fhirFolder = "FHIR"

# Leer todos los archivos HL7
$hl7Files = Get-ChildItem -Path $hl7Folder -Filter "*.hl7"

foreach ($file in $hl7Files) {
    $lines = Get-Content $file.FullName

    # Extraer información básica (ejemplo simple)
    $pidLine = $lines | Where-Object { $_ -like "PID*" }
    $pidFields = $pidLine -split "\|"
    $id = $pidFields[3]
    $nombreCompleto = $pidFields[5]
    $nombreArray = $nombreCompleto -split "\^"
    $nombre = $nombreArray[1]
    $apellido = $nombreArray[0]
    $fechaNacimiento = $pidFields[7]
    $sexo = $pidFields[8]

    # Crear JSON FHIR básico
    $fhirPatient = @{
        resourceType = "Patient"
        id = $id
        name = @(@{given = @($nombre); family = $apellido})
        gender = if ($sexo -eq "M") {"male"} else {"female"}
        birthDate = $fechaNacimiento
    } | ConvertTo-Json -Depth 3

    # Guardar JSON en carpeta FHIR
    $jsonFile = Join-Path $fhirFolder ($file.BaseName + ".json")
    $fhirPatient | Out-File -FilePath $jsonFile -Encoding utf8
}

Write-Host "Transformación HL7 → FHIR completa."