#!/bin/sh

if [ $# -ne 2 ]; then
  echo "Usage: $(basename $0) <radio-type> <mtcdt-type>"
  echo "    Example: all_config.sh LAT1 240L"
  exit 1
fi

out="/sys/bus/i2c/devices/0-0056/eeprom"

vendor_id="Multi-Tech Systems"
product_id="MTCDT-$1-$2"
device_id="12345678"
hw_version="MTCDT-0.1"
mac_addr="00:08:00:4A:1F:F1"
wifi_mac_addr="00:23:A7:43:C6:98"
bt_mac_addr="00:23:A7:49:66:C5"
imei="999999999999999"
uuid="9c9a9a99ccf9a9cbffbd9cc999bc9c99"
capa="--capa-gps"

set -xe

mts-id-eeprom --out-file $out --out-format bin --vendor-id "$vendor_id" \
  --product-id "$product_id" --device-id "$device_id" \
  --hw-version "$hw_version" --mac-addr "$mac_addr" \
  --mac-bluetooth "$bt_mac_addr" --mac-wifi "$wifi_mac_addr" \
  --imei "$imei" --uuid "$uuid" \
  $capa

set +x

echo -e "\n\nNew contents"
echo    "-----------------"
mts-id-eeprom --in-file $out
