echo off
setlocal EnableDelayedExpansion
cls

Rem Python Version Def
Set "MajorVersion=3"
Set "MinorVersion=11"
Set "PatchVersion=7"

pushd %~dp0

if exist "python-embed-amd64" rmdir /s /q "python-embed-amd64">nul 2>&1
if exist "python-embed-amd64.zip" del /f /q "python-embed-amd64.zip">nul 2>&1

echo Embedded Python
curl -L --ssl-no-revoke -o "python-embed-amd64.zip" "https://www.python.org/ftp/python/%MajorVersion%.%MinorVersion%.%PatchVersion%/python-%MajorVersion%.%MinorVersion%.%PatchVersion%-embed-amd64.zip"
echo.

mkdir "python-embed-amd64"
tar -xf python-embed-amd64.zip -C ./python-embed-amd64
del /f /q "python-embed-amd64.zip">nul 2>&1
cd python-embed-amd64
echo import site>>python311._pth

Rem Get Pip
echo get-pip.py 
curl -L --ssl-no-revoke -o "get-pip.py" "https://bootstrap.pypa.io/get-pip.py"
echo.
python.exe get-pip.py --no-warn-script-location
echo.

Rem get Modules
Scripts\pip.exe install pyside6 certifi --no-warn-script-location
echo.

Rem add the BAE cert info to the certifi certificate store
call :BAE_CERT

cd..

echo Zipping...
zip -r python-embed-amd64.zip python-embed-amd64>nul 2>&1

pause

exit 0

:BAE_CERT
set "cacert=Lib\site-packages\certifi\cacert.pem"
echo. >>%cacert%
echo # BAE Certificates>>%cacert%
echo -----BEGIN CERTIFICATE----->>%cacert%
echo MIIDJzCCAg+gAwIBAgIQFKg91xGOC5dEY4Yc8hdcRDANBgkqhkiG9w0BAQsFADAm>>%cacert%
echo MSQwIgYDVQQDExtCQUUgU3lzdGVtcyBSb290IENBIFVLIDIwMTUwHhcNMTUwNTAz>>%cacert%
echo MjEzNTI2WhcNMzUwNTAzMjE0NTI2WjAmMSQwIgYDVQQDExtCQUUgU3lzdGVtcyBS>>%cacert%
echo b290IENBIFVLIDIwMTUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCk>>%cacert%
echo 0rWesvkl5OgSk86dprQrIXrHCoCKV72HVRACPIVb7JevnyS72N5KLcM0/4pORaDI>>%cacert%
echo weVl8Y7plzvrYDhwtIPeyTyuAi99+vvZkcxFznTKjZDHMa0YGK3R/SltVUy5Tx+7>>%cacert%
echo HjaQoxqOge+HPF4zW1mxxMZDD8h5w+iiLcojBmTU5URmCAm51DXNy0+7o6YSlNbc>>%cacert%
echo F2WtlGzBpjNHbokVxhiLDOYDzU+idZA926ZQdrgZTBSBQgj43TC6S5B672jGkcXW>>%cacert%
echo OGuy5S/F/mOep7CoVgzAB7XTEKq0gsrOQBGU+qJ5MaYJaKsbriTKxAywsoZm7Vdp>>%cacert%
echo keMD5G1qqRLFNiagpWXHAgMBAAGjUTBPMAsGA1UdDwQEAwIBhjAPBgNVHRMBAf8E>>%cacert%
echo BTADAQH/MB0GA1UdDgQWBBTNtlhJQa1HqHAXVTLEvOFmeMK/ODAQBgkrBgEEAYI3>>%cacert%
echo FQEEAwIBADANBgkqhkiG9w0BAQsFAAOCAQEABXc4vgueKp+KHhm4S/hzzYmZGo+v>>%cacert%
echo fsDBBT3K/GC265gdruZpNn+bs+3RrDYlDuWG6u539ba/EURGnrOkrsvkIV+UB24t>>%cacert%
echo c47xslccE5DnxZRr+rUyYRM4doUyI49fFUpXvNWrRyJJMFu7Mf0yiwe3q8O2TtEM>>%cacert%
echo bP9OBbCIpdbgIO0cGOYEhPHLZXBjP5qVnF6hygFqlBReqUMwM3na9qvGxTuQmJXp>>%cacert%
echo UuxPfUSgLag6/Izz9YR5xpLbltQPR0RFs0zjb6boArjpt6xKCS7fJL+4XIL3vqza>>%cacert%
echo yNXKDaHGdixx+HTKu/30ezC/gbvwjig8KeIkDZ0f8Ze2fX3aU4PixLOxpg==>>%cacert%
echo -----END CERTIFICATE----->>%cacert%
echo. >>%cacert%
echo -----BEGIN CERTIFICATE----->>%cacert%
echo MIIGCzCCBPOgAwIBAgITEwAAABfSTPS5V26yCAAAAAAAFzANBgkqhkiG9w0BAQsF>>%cacert%
echo ADAmMSQwIgYDVQQDExtCQUUgU3lzdGVtcyBSb290IENBIFVLIDIwMTUwHhcNMjIw>>%cacert%
echo NTEwMTIxOTQxWhcNMzIwNTEwMTIyOTQxWjCBpTELMAkGA1UEBhMCR0IxCzAJBgNV>>%cacert%
echo BAgTAlVLMRAwDgYDVQQHEwdFbmdsYW5kMREwDwYDVQQKEwhOZXR3b3JrczEOMAwG>>%cacert%
echo A1UECxMFUHJveHkxJTAjBgNVBAMTHEJBRSBTeXN0ZW1zIEludGVybmV0IFByb3hp>>%cacert%
echo ZXMxLTArBgkqhkiG9w0BCQEWHnBoaWwubS5nYXJkaW5lckBiYWVzeXN0ZW1zLmNv>>%cacert%
echo bTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAP3JMfpDi/+4B0NTfDXs>>%cacert%
echo nLPV7K1un8K5sCTn6sNG9s1bB7jWnWdAlakCPZ7qpDEtRI7nX9KzSJRosaEMsKCa>>%cacert%
echo rSRNqk2+q6WEjx1T7ul+k24CBUPjgqzr2CwRlbVrBkHqOX9przqQZm5UVrLuH37X>>%cacert%
echo I0kKvpJQsT6H39BR6z98L1Wn+oxc8pAPFF1ZxV17rd+bF5OAs/VAnMZ1C8rgn18M>>%cacert%
echo cIxJfKlO9xEzdOwp6H97i8Sjpq3DgztLpM8KmcQQd/UCWB7a8Z6Qq4L1176LyXWF>>%cacert%
echo Gtw+Q8ulKe2dbx4qpqjL6AaFS0zb0kUX1OHzimO8LdyeEBGNR2xFNe+hgP4L0n8z>>%cacert%
echo Y3sCAwEAAaOCArAwggKsMB0GA1UdDgQWBBQm5Mtnfb5tKFRIRrvb9qnIedhdnDAf>>%cacert%
echo BgNVHSMEGDAWgBTNtlhJQa1HqHAXVTLEvOFmeMK/ODCB8wYDVR0fBIHrMIHoMIHl>>%cacert%
echo oIHioIHfhkpodHRwOi8vY3JsLndoaXRlbG5rLnJvb3RsbmtjLm5ldC9CQUUlMjBT>>%cacert%
echo eXN0ZW1zJTIwUm9vdCUyMENBJTIwVUslMjAyMDE1LmNybIZGaHR0cDovL2NybC51>>%cacert%
echo ay5iYWVzeXN0ZW1zLmNvbS9CQUUlMjBTeXN0ZW1zJTIwUm9vdCUyMENBJTIwVUsl>>%cacert%
echo MjAyMDE1LmNybIZJaHR0cDovL3BraS5wdXJwbGUuemVicmEuYWQvY3JsZC9CQUUl>>%cacert%
echo MjBTeXN0ZW1zJTIwUm9vdCUyMENBJTIwVUslMjAyMDE1LmNybDCCATkGCCsGAQUF>>%cacert%
echo BwEBBIIBKzCCAScwXgYIKwYBBQUHMAKGUmh0dHA6Ly9jcmwudWsuYmFlc3lzdGVt>>%cacert%
echo cy5jb20vQkFFU1VLUkNBMDFfQkFFJTIwU3lzdGVtcyUyMFJvb3QlMjBDQSUyMFVL>>%cacert%
echo JTIwMjAxNS5jcnQwYgYIKwYBBQUHMAKGVmh0dHA6Ly9jcmwud2hpdGVsbmsucm9v>>%cacert%
echo dGxua2MubmV0L0JBRVNVS1JDQTAxX0JBRSUyMFN5c3RlbXMlMjBSb290JTIwQ0El>>%cacert%
echo MjBVSyUyMDIwMTUuY3J0MGEGCCsGAQUFBzAChlVodHRwOi8vcGtpLnB1cnBsZS56>>%cacert%
echo ZWJyYS5hZC9jcmxkL0JBRVNVS1JDQTAxX0JBRSUyMFN5c3RlbXMlMjBSb290JTIw>>%cacert%
echo Q0ElMjBVSyUyMDIwMTUuY3J0MBkGCSsGAQQBgjcUAgQMHgoAUwB1AGIAQwBBMA8G>>%cacert%
echo A1UdEwEB/wQFMAMBAf8wCwYDVR0PBAQDAgGGMA0GCSqGSIb3DQEBCwUAA4IBAQAC>>%cacert%
echo yzU/B8lRU60w5B1gNJ3m+Kt7XEELrCYGopKpScxi0z6cdNIoinWfWf4FVO/Ewg1c>>%cacert%
echo Nhpn/jMMPPrybQpaLGshV7uWkbMP6lXi0BCr8Zfet8tuId9nZ4d/CQA82K/SOgKx>>%cacert%
echo E/h1kBjVSHMXEwqlM8rxtUF5cEt8Dvci+sdj2gVh/H5GtE+k8dDa4Cr4YzGFuIC0>>%cacert%
echo 788yowEewi3mNWZvoH1BaH/kWqV74LMcdG5mf95dMB/g0HeEo20RYodVdd+L9qdH>>%cacert%
echo PILkjtHU9vrRfStBRNPnn9M1K8GAb6izO7eMbO37wA4TPwHQ38wP0mOdJA7O4jFY>>%cacert%
echo +aT/dhOUw67g2ugok0ei>>%cacert%
echo -----END CERTIFICATE----->>%cacert%
echo. >>%cacert%
echo -----BEGIN CERTIFICATE----->>%cacert%
echo MIIEkTCCA3mgAwIBAgIJALM/JTcAAAAAMA0GCSqGSIb3DQEBCwUAMIGlMQswCQYD>>%cacert%
echo VQQGEwJHQjELMAkGA1UECBMCVUsxEDAOBgNVBAcTB0VuZ2xhbmQxETAPBgNVBAoT>>%cacert%
echo CE5ldHdvcmtzMQ4wDAYDVQQLEwVQcm94eTElMCMGA1UEAxMcQkFFIFN5c3RlbXMg>>%cacert%
echo SW50ZXJuZXQgUHJveGllczEtMCsGCSqGSIb3DQEJARYecGhpbC5tLmdhcmRpbmVy>>%cacert%
echo QGJhZXN5c3RlbXMuY29tMB4XDTIyMDcyNjE5NDUxNFoXDTIzMDgyNzE5NDUxM1ow>>%cacert%
echo EzERMA8GA1UEAwwIcHlwaS5vcmcwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK>>%cacert%
echo AoIBAQDKTMFwNAFxB+2nu1JboIIp0495TEAxEYIWPjzY8nV5Ig+krAq2Qh0QxIXj>>%cacert%
echo Ko+Aawe61im3dpCoa2Co4Y/ekc4rBLxj0pRNfXLUstdCn1D5AWlpZ323Wx50TRVh>>%cacert%
echo XG2ULOVBD07dkJk9tURvwEfJqxJVN1jdMNDC4vBT+VoURQOu/CiYTRTt1eEV48ZU>>%cacert%
echo 4Qbn039SK0+HCLszvtUYV2d197me4sfQFkM0UdRYKo6i1igZv24l42eaRdC1oFjV>>%cacert%
echo WlRnlkqY/y7gV1x7uYY1ivudKZbCY0PpI6uja3YTX7l1U1ZbD2g3oVhbvfDCpNdR>>%cacert%
echo V5nJ7o2ytrGzLdyBv3NTGM9sPDAFAgMBAAGjggFTMIIBTzAJBgNVHRMEAjAAMAsG>>%cacert%
echo A1UdDwQEAwIF4DAfBgNVHSMEGDAWgBQm5Mtnfb5tKFRIRrvb9qnIedhdnDA+BgNV>>%cacert%
echo HREENzA1gghweXBpLm9yZ4IKKi5weXBpLm9yZ4IMd3d3LnB5cGkub3Jngg9kb25h>>%cacert%
echo dGUucHlwaS5vcmcwXwYJYIZIAYb4QgENBFIWUDAxRUVBOUU5QkVCMzc0RkY2RUU2>>%cacert%
echo NkM5NjU4RkJBNERCSnVsIDI2IDE5OjQ1OjE0IDIwMjIgR01UQXVnIDI3IDE5OjQ1>>%cacert%
echo OjEzIDIwMjMgR01UMHMGA1UdIARsMGowaAYEVR0gADBgMF4GCCsGAQUFBwICMFIa>>%cacert%
echo UDAxRUVBOUU5QkVCMzc0RkY2RUU2NkM5NjU4RkJBNERCSnVsIDI2IDE5OjQ1OjE0>>%cacert%
echo IDIwMjIgR01UQXVnIDI3IDE5OjQ1OjEzIDIwMjMgR01UMA0GCSqGSIb3DQEBCwUA>>%cacert%
echo A4IBAQB0Y9/JG9Obl0R+O7r/9a7tb+2TfGF17N04GVv1rysRBm+E6WwKwQixViga>>%cacert%
echo SUJzi+79PtevoZHMFpyknTsZhJMOFWPblsxu9oLcpOF1t+dxtI7GmrCBuMdwM782>>%cacert%
echo /XvXqQmmo5pG4xZbN+ujEfaPVtBdVZoGMjSMN01V7TP1BDPsBjFo5mjzOi0WybSP>>%cacert%
echo EvoYcqglWqKOFJHVenpWzOdxInYS8Jn+qcc4zeaeMYQgly+o4PtdY9n2UCyGhukb>>%cacert%
echo 7z+0sRi54I+umWtJPw0mj6mTB6iO7bSvGBHDyOf2WFV+5D5jwOrA/RpgW/j1gRon>>%cacert%
echo FHxbrSpv8k1lEb6yDafBT+QsXVhb>>%cacert%
echo -----END CERTIFICATE----->>%cacert%