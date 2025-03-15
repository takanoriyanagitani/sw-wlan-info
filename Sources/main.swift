import class CoreWLAN.CWChannel
import enum CoreWLAN.CWChannelBand
import enum CoreWLAN.CWChannelWidth
import class CoreWLAN.CWInterface
import enum CoreWLAN.CWInterfaceMode
import enum CoreWLAN.CWPHYMode
import class CoreWLAN.CWWiFiClient

func phy2str(_ p: CWPHYMode) -> String {
  switch p {
  case .modeNone: return "none"
  case .mode11a: return "11a"
  case .mode11b: return "11b"
  case .mode11g: return "11g"
  case .mode11n: return "11n"
  case .mode11ac: return "11ac"
  case .mode11ax: return "11ax"

  @unknown default: return "UNKNOWN"
  }
}

func ifmode2str(_ m: CWInterfaceMode) -> String {
  switch m {
  case .none: return "none"
  case .station: return "station"
  case .IBSS: return "IBSS"
  case .hostAP: return "hostAP"

  @unknown default: return "UNKNOWN"
  }
}

func band2str(_ b: CWChannelBand) -> String {
  switch b {
  case .bandUnknown: "unknown"
  case .band2GHz: "2GHz"
  case .band5GHz: "5GHz"
  case .band6GHz: "6GHz"

  @unknown default: "UNKNOWN"
  }
}

func width2str(_ w: CWChannelWidth) -> String {
  switch w {
  case .widthUnknown: "unknown"
  case .width20MHz: "20 MHz"
  case .width40MHz: "40 MHz"
  case .width80MHz: "80 MHz"
  case .width160MHz: "160 MHz"

  @unknown default: "UNKNOWN"
  }
}

func printChan(_ ch: CWChannel) {
  print("channel.band: \( band2str(ch.channelBand) )")
  print("channel.number: \( ch.channelNumber )")
  print("channel.width: \( width2str(ch.channelWidth) )")
}

func printInterface(_ iface: CWInterface) {
  print("interface name: \( iface.interfaceName ?? "" )")
  print("active PHY Mode: \( phy2str(iface.activePHYMode()) )")
  print("BSSID: \( iface.bssid() ?? "" )")
  print("country code: \( iface.countryCode() ?? "" )")
  print("hardware address: \( iface.hardwareAddress() ?? "" )")
  print("interface mode: \( ifmode2str(iface.interfaceMode()) )")
  print("noise: \( iface.noiseMeasurement() )")
  print("powered: \( iface.powerOn() )")
  print("RSSI: \( iface.rssiValue() )")
  print("security: \( iface.security() )")
  print("has active service: \( iface.serviceActive() )")
  print("SSID: \( iface.ssid() ?? "" )")
  print("transmit power [mW]: \( iface.transmitPower() )")
  print("transmit rate [Mbps]: \( iface.transmitRate() )")
  if let ch = iface.wlanChannel() {
    printChan(ch)
  }
}

@main
struct WlanInfo {
  static func main() {
    let wcli: CWWiFiClient = .shared()
    let ifaces: [CWInterface] = wcli.interfaces() ?? []
    for iface in ifaces {
      printInterface(iface)
    }
  }
}
