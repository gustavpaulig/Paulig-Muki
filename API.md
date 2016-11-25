# Paulig Muki API

:exclamation: The information in this document has been acquired via creative reverse engineering.

# Technical Features

## Image Format

* Resolution: 176 x 264 px
* Monochrome (bitmap) (46464 bits = 5808 bytes)
* Format: "rotated 90 degrees counterclockwise"?

Provisional conversion code, assuming PIL image:

```python
def bitmap_to_bytes(image):
  width, height = image.size
  bytes = [0] * (width * height / 8)
  i = 0
  for x in range(0, width):
    for y in range(height - 1, -1, -1):
      pixel = image[(x, y)]
      byte, bit = divmod(i, 8)
      bytes[byte] |= (color << bit)
  return bytes
```

# Cup Number to Bluetooth ID Mapping

The Paulig Muki REST API has an endpoint for mapping the cup number (printed on the bottom of the Muki) to its Bluetooth device name:

https://back.pauligmuki.fi/smartcc/rest/V1/number/long/%s (replace the %s with the 7-digit zero-padded cup number).

The endpoint will respond with a JSON blob like

```
{"code":"0","result":{"number":"PAULIG_MUKI_C0FFEE"}}
```

where the `number` field corresponds to the Bluetooth device name.

# Services

## Main Service

UUIDs:

* 6E400001-B5A3-F393-E0A9-E50E24DCCA9E (old)
* 06640001-9087-04A8-658F-CE44CB96B4A1 (new)

### Transmit Characteristic

This characteristic is the entry point for writing into the image memory.

UUIDs:

* 6E400002-B5A3-F393-E0A9-E50E24DCCA9E (old)
* 06640002-9087-04A8-658F-CE44CB96B4A1 (new)

## Firmware Service

UUID: 0000180a-0000-1000-8000-00805f9b34fb

### Property characteristics

These characteristics house various device properties.

* Model number: 00002a24-0000-1000-8000-00805f9b34fb
* Manufacturer: 00002a29-0000-1000-8000-00805f9b34fb
* Hardware Revision: 00002a27-0000-1000-8000-00805f9b34fb
* Firmware Revision: 00002a26-0000-1000-8000-00805f9b34fb

# Functionality

## Enumerate device info

* Find firmware service UUID
* Read the string value (at offset 0) of each property characteristic

## Clear image

* Find Main service UUID and transmit characteristic within the service
* Write character 'c' (0x63) to transmit characteristic (default write type)

## Transmit image

* Find Main service UUID and transmit characteristic within the service
* Write character 't' (0x74) to transmit characteristic (default write type)
* Loop 291 times: write up to 20-byte array of image data to transmit characteristic (no-response write type)
  * Last iteration should only write 18 bytes (290 * 20 + 18 = 5818)

* Write character 'd' (0x64) to transmit characteristic (default write type)
