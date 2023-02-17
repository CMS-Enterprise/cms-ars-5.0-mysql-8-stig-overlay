overlay_controls = input('overlay_controls')
system_categorization = input('system_categorization')

include_controls 'oracle-mysql-8-stig-baseline' do

  ## NIST tags updated due to changes between NIST SP 800-53 rev 4 and rev 5 (https://csrc.nist.gov/csrc/media/Publications/sp/800-53/rev-5/final/documents/sp800-53r4-to-r5-comparison-workbook.xlsx)

  ## PL-9 incorporates withdrawn control AU-3 (2)
  control 'SV-235171' do
    tag nist: ["PL-9"]
  end

  control 'SV-235172' do
    tag nist: ["PL-9"]
  end

  ## Semantic changes

  control 'SV-235167' do
    title "The MySQL Database Server 8.0 must disable network functions, ports, protocols, and services deemed by the organization to be nonsecure, in accord with the Ports, Protocols, and Services Management (PPSM) guidance."
    desc 'fix', "Disable each prohibited network function, port, protocol, or service.

    Change mysql options related to network, ports, and protocols for the server and additionally consider refining further at user account level.

    To set ports properly, edit the mysql configuration file and change ports or protocol settings.

    vi my.cnf
    [mysqld]
    port=<port value>
    admin_port=<port value>
    mysqlx_port=<port value>
    socket=/path/to/socket

    To turn off TCP/IP:

    skip_networking=ON

    If admin_address is not defined then access via the admin port is disabled.

    Additionally the X Plugin can be disabled at startup/restart by either setting mysqlx=0 in the MySQL configuration file, or by passing in either \"--mysqlx=0\" or \"--skip-mysqlx\" when starting the MySQL server."
  end

  control 'SV-235146' do
    title "The MySQL Database Server 8.0 must be configured to prohibit or restrict the use of organization-defined functions, ports, protocols, and/or services."
  end

  ## NA due to the requirement not included in CMS ARS 5.0
  unless overlay_controls.empty?
    overlay_controls.each do |overlay_control|
      control overlay_control do
        impact 0.0
        desc "caveat", "Not applicable for this CMS ARS 5.0 overlay, since the requirement is not included in CMS ARS 5.0"
      end
    end
  end
end
