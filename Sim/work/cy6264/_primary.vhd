library verilog;
use verilog.vl_types.all;
entity cy6264 is
    port(
        io              : inout  vl_logic_vector(7 downto 0);
        addr            : in     vl_logic_vector(12 downto 0);
        lce1            : in     vl_logic;
        ce2             : in     vl_logic;
        lwe             : in     vl_logic;
        loe             : in     vl_logic
    );
end cy6264;
