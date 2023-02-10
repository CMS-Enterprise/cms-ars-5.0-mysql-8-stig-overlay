overlay_controls = input('overlay_controls')
system_categorization = input('system_categorization')

include_controls 'oracle-mysql-8-stig-baseline' do
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

## NIST tags updated due to changes between NIST SP 800-53 rev 4 and rev 5 (https://csrc.nist.gov/csrc/media/Publications/sp/800-53/rev-5/final/documents/sp800-53r4-to-r5-comparison-workbook.xlsx)

## PL-9 incorporates withdrawn control AU-3 (2)
control 'SV-235171' do
    tag nist: ["PL-9"]
end

control 'SV-235172' do
    tag nist: ["PL-9"]
end