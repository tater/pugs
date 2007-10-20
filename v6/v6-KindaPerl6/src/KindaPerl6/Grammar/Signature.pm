
use v6-alpha;

grammar KindaPerl6::Grammar {

    # has $.is_longname; ???
    token parameter_named_only       { ':' { return 1 } | { return 0 } }
    token parameter_optional         { '?' { return 1 } | { return 0 } }
    token parameter_slurpy           { '*' { return 1 } | { return 0 } }
    token parameter_multidimensional { '@' { return 1 } | { return 0 } }

    token exp_parameter_item {
        |   <parameter_slurpy> <pair>  
            { return ::Lit::NamedArgument( 
                    key   => ($$<pair>)[0], 
                    value => ($$<pair>)[1],
                    # is_slurpy => ...
                ) }
        |   <exp>   { return $$<exp>   }
    }

    token exp_parameter_list {
        |   <exp_parameter_item> 
            [
            |   <?opt_ws> \, <?opt_ws> <exp_parameter_list> 
                { return [ $$<exp_parameter_item>, @( $$<exp_parameter_list> ) ] }
            |   <?opt_ws> [ \, <?opt_ws> | '' ]
                { return [ $$<exp_parameter_item> ] }
            ]
        |
            { return [ ] }
    };

    token sig {
        <invocant>
        <?opt_ws> 
        # TODO - exp_seq / exp_mapping == positional / named 
        # ??? exp_parameter_list
        <exp_seq> 
        {
            # say ' invocant: ', ($$<invocant>).perl;
            # say ' positional: ', ($$<exp_seq>).perl;
            return ::Sig( 'invocant' => $$<invocant>, 'positional' => $$<exp_seq>, 'named' => { } );
        }
    };


}
