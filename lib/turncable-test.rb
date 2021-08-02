require 'taptag'
require 'taptag/nfc'
require_relative './spotify_client.rb'

client = SpotifyClient.new
puts client.api.connect.devices

Taptag::NFC.interface_type = :i2c
puts "Card UUID: #{Taptag::NFC.card_uid}"

puts "Reading: #{Taptag::NFC.read_ntag_card}"

puts "Writing..."
data = "zzz"
bytes = Taptag::Encoder.encode_string(data)  
Taptag::NFC.write_ntag_block(0, bytes)

puts "Reading: #{Taptag::NFC.read_ntag_card}"
