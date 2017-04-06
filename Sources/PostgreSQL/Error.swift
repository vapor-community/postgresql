import CPostgreSQL

/// A list of all Error messages that
/// can be thrown from calls to `Database`.
///
/// All Error objects contain a String which
/// contains PostgreSQL's last error message.
public struct PostgreSQLError: Error {
    public let code: Code
    public let reason: String
}

extension PostgreSQLError {
    public enum Code: String {
        case successful_completion = "00000"
        // Class 01 — Warning
        case warning = "01000"
        case dynamic_result_sets_returned = "0100C"
        case implicit_zero_bit_padding = "01008"
        case null_value_eliminated_in_set_function = "01003"
        case privilege_not_granted = "01007"
        case privilege_not_revoked = "01006"
        case string_data_right_truncation = "01004"
        case deprecated_feature = "01P01"
        // Class 02 — No Data (this is also a warning class per the SQL standard)
        case no_data = "02000"
        case no_additional_dynamic_result_sets_returned = "02001"
        // Class 03 — SQL Statement Not Yet Complete
        case sql_statement_not_yet_complete = "03000"
        // Class 08 — Connection Exception
        case connection_exception = "08000"
        case connection_does_not_exist = "08003"
        case connection_failure = "08006"
        case sqlclient_unable_to_establish_sqlconnection = "08001"
        case sqlserver_rejected_establishment_of_sqlconnection = "08004"
        case transaction_resolution_unknown = "08007"
        case protocol_violation = "08P01"
        // Class 09 — Triggered Action Exception
        case triggered_action_exception = "09000"
        // Class  0A — Feature Not Supported
        case feature_not_supported = "0A000"
        // Class  0B — Invalid Transaction Initiation
        case invalid_transaction_initiation = "0B000"
        // Class 0F — Locator Exception
        case locator_exception = "0F000"
        case invalid_locator_specification = "0F001"
        // Class 0L — Invalid Grantor
        case invalid_grantor = "0L000"
        case invalid_grant_operation = "0LP01"
        // Class 0P — Invalid Role Specification
        case invalid_role_specification = "0P000"
        // Class 0Z — Diagnostics Exception
        case diagnostics_exception = "0Z000"
        case stacked_diagnostics_accessed_without_active_handler = "0Z002"
        // Class 20 — Case Not Found
        case case_not_found = "20000"
        // Class 21 — Cardinality Violation
        case cardinality_violation = "21000"
        // Class 22 — Data Exception
        case data_exception = "22000"
        case array_subscript_error = "2202E"
        case character_not_in_repertoire = "22021"
        case datetime_field_overflow = "22008"
        case division_by_zero = "22012"
        case error_in_assignment = "22005"
        case escape_character_conflict = "2200B"
        case indicator_overflow = "22022"
        case interval_field_overflow = "22015"
        case invalid_argument_for_logarithm = "2201E"
        case invalid_argument_for_ntile_function = "22014"
        case invalid_argument_for_nth_value_function = "22016"
        case invalid_argument_for_power_function = "2201F"
        case invalid_argument_for_width_bucket_function = "2201G"
        case invalid_character_value_for_cast = "22018"
        case invalid_datetime_format = "22007"
        case invalid_escape_character = "22019"
        case invalid_escape_octet = "2200D"
        case invalid_escape_sequence = "22025"
        case nonstandard_use_of_escape_character = "22P06"
        case invalid_indicator_parameter_value = "22010"
        case invalid_parameter_value = "22023"
        case invalid_regular_expression = "2201B"
        case invalid_row_count_in_limit_clause = "2201W"
        case invalid_row_count_in_result_offset_clause = "2201X"
        case invalid_tablesample_argument = "2202H"
        case invalid_tablesample_repeat = "2202G"
        case invalid_time_zone_displacement_value = "22009"
        case invalid_use_of_escape_character = "2200C"
        case most_specific_type_mismatch = "2200G"
        case null_value_not_allowed = "22004"
        case null_value_no_indicator_parameter = "22002"
        case numeric_value_out_of_range = "22003"
        case string_data_length_mismatch = "22026"
        // case string_data_right_truncation = "22001"
        case substring_error = "22011"
        case trim_error = "22027"
        case unterminated_c_string = "22024"
        case zero_length_character_string = "2200F"
        case floating_point_exception = "22P01"
        case invalid_text_representation = "22P02"
        case invalid_binary_representation = "22P03"
        case bad_copy_file_format = "22P04"
        case untranslatable_character = "22P05"
        case not_an_xml_document = "2200L"
        case invalid_xml_document = "2200M"
        case invalid_xml_content = "2200N"
        case invalid_xml_comment = "2200S"
        case invalid_xml_processing_instruction = "2200T"
        // Class 23 — Integrity Constraint Violation
        case integrity_constraint_violation = "23000"
        case restrict_violation = "23001"
        case not_null_violation = "23502"
        case foreign_key_violation = "23503"
        case unique_violation = "23505"
        case check_violation = "23514"
        case exclusion_violation = "23P01"
        // Class 24 — Invalid Cursor State
        case invalid_cursor_state = "24000"
        // Class 25 — Invalid Transaction State
        case invalid_transaction_state = "25000"
        case active_sql_transaction = "25001"
        case branch_transaction_already_active = "25002"
        case held_cursor_requires_same_isolation_level = "25008"
        case inappropriate_access_mode_for_branch_transaction = "25003"
        case inappropriate_isolation_level_for_branch_transaction = "25004"
        case no_active_sql_transaction_for_branch_transaction = "25005"
        case read_only_sql_transaction = "25006"
        case schema_and_data_statement_mixing_not_supported = "25007"
        case no_active_sql_transaction = "25P01"
        case in_failed_sql_transaction = "25P02"
        case idle_in_transaction_session_timeout = "25P03"
        // Class 26 — Invalid SQL Statement Name
        case invalid_sql_statement_name = "26000"
        // Class 27 — Triggered Data Change Violation
        case triggered_data_change_violation = "27000"
        // Class 28 — Invalid Authorization Specification
        case invalid_authorization_specification = "28000"
        case invalid_password = "28P01"
        // Class 2B — Dependent Privilege Descriptors Still Exist
        case dependent_privilege_descriptors_still_exist = "2B000"
        case dependent_objects_still_exist = "2BP01"
        // Class 2D — Invalid Transaction Termination
        case invalid_transaction_termination = "2D000"
        // Class 2F — SQL Routine Exception
        case sql_routine_exception = "2F000"
        case function_executed_no_return_statement = "2F005"
        case modifying_sql_data_not_permitted = "2F002"
        case prohibited_sql_statement_attempted = "2F003"
        case reading_sql_data_not_permitted = "2F004"
        // Class 34 — Invalid Cursor Name
        case invalid_cursor_name = "34000"
        // Class 38 — External Routine Exception
        case external_routine_exception = "38000"
        case containing_sql_not_permitted = "38001"
        // case modifying_sql_data_not_permitted = "38002"
        // case prohibited_sql_statement_attempted = "38003"
        // case reading_sql_data_not_permitted = "38004"
        // Class 39 — External Routine Invocation Exception
        case external_routine_invocation_exception = "39000"
        case invalid_sqlstate_returned = "39001"
        // case null_value_not_allowed = "39004"
        case trigger_protocol_violated = "39P01"
        case srf_protocol_violated = "39P02"
        case event_trigger_protocol_violated = "39P03"
        // Class 3B — Savepoint Exception
        case savepoint_exception = "3B000"
        case invalid_savepoint_specification = "3B001"
        // Class 3D — Invalid Catalog Name
        case invalid_catalog_name = "3D000"
        // Class 3F — Invalid Schema Name
        case invalid_schema_name = "3F000"
        // Class 40 — Transaction Rollback
        case transaction_rollback = "40000"
        case transaction_integrity_constraint_violation = "40002"
        case serialization_failure = "40001"
        case statement_completion_unknown = "40003"
        case deadlock_detected = "40P01"
        // Class 42 — Syntax Error or Access Rule Violation
        case syntax_error_or_access_rule_violation = "42000"
        case syntax_error = "42601"
        case insufficient_privilege = "42501"
        case cannot_coerce = "42846"
        case grouping_error = "42803"
        case windowing_error = "42P20"
        case invalid_recursion = "42P19"
        case invalid_foreign_key = "42830"
        case invalid_name = "42602"
        case name_too_long = "42622"
        case reserved_name = "42939"
        case datatype_mismatch = "42804"
        case indeterminate_datatype = "42P18"
        case collation_mismatch = "42P21"
        case indeterminate_collation = "42P22"
        case wrong_object_type = "42809"
        case undefined_column = "42703"
        case undefined_function = "42883"
        case undefined_table = "42P01"
        case undefined_parameter = "42P02"
        case undefined_object = "42704"
        case duplicate_column = "42701"
        case duplicate_cursor = "42P03"
        case duplicate_database = "42P04"
        case duplicate_function = "42723"
        case duplicate_prepared_statement = "42P05"
        case duplicate_schema = "42P06"
        case duplicate_table = "42P07"
        case duplicate_alias = "42712"
        case duplicate_object = "42710"
        case ambiguous_column = "42702"
        case ambiguous_function = "42725"
        case ambiguous_parameter = "42P08"
        case ambiguous_alias = "42P09"
        case invalid_column_reference = "42P10"
        case invalid_column_definition = "42611"
        case invalid_cursor_definition = "42P11"
        case invalid_database_definition = "42P12"
        case invalid_function_definition = "42P13"
        case invalid_prepared_statement_definition = "42P14"
        case invalid_schema_definition = "42P15"
        case invalid_table_definition = "42P16"
        case invalid_object_definition = "42P17"
        // Class 44 — WITH CHECK OPTION Violation
        case with_check_option_violation = "44000"
        // Class 53 — Insufficient Resources
        case insufficient_resources = "53000"
        case disk_full = "53100"
        case out_of_memory = "53200"
        case too_many_connections = "53300"
        case configuration_limit_exceeded = "53400"
        // Class 54 — Program Limit Exceeded
        case program_limit_exceeded = "54000"
        case statement_too_complex = "54001"
        case too_many_columns = "54011"
        case too_many_arguments = "54023"
        // Class 55 — Object Not In Prerequisite State
        case object_not_in_prerequisite_state = "55000"
        case object_in_use = "55006"
        case cant_change_runtime_param = "55P02"
        case lock_not_available = "55P03"
        // Class 57 — Operator Intervention
        case operator_intervention = "57000"
        case query_canceled = "57014"
        case admin_shutdown = "57P01"
        case crash_shutdown = "57P02"
        case cannot_connect_now = "57P03"
        case database_dropped = "57P04"
        // Class 58 — System Error (errors external to PostgreSQL itself)
        case system_error = "58000"
        case io_error = "58030"
        case undefined_file = "58P01"
        case duplicate_file = "58P02"
        // Class 72 — Snapshot Failure
        case snapshot_too_old = "72000"
        // Class F0 — Configuration File Error
        case config_file_error = "F0000"
        case lock_file_exists = "F0001"
        // Class HV — Foreign Data Wrapper Error (SQL/MED)
        case fdw_error = "HV000"
        case fdw_column_name_not_found = "HV005"
        case fdw_dynamic_parameter_value_needed = "HV002"
        case fdw_function_sequence_error = "HV010"
        case fdw_inconsistent_descriptor_information = "HV021"
        case fdw_invalid_attribute_value = "HV024"
        case fdw_invalid_column_name = "HV007"
        case fdw_invalid_column_number = "HV008"
        case fdw_invalid_data_type = "HV004"
        case fdw_invalid_data_type_descriptors = "HV006"
        case fdw_invalid_descriptor_field_identifier = "HV091"
        case fdw_invalid_handle = "HV00B"
        case fdw_invalid_option_index = "HV00C"
        case fdw_invalid_option_name = "HV00D"
        case fdw_invalid_string_length_or_buffer_length = "HV090"
        case fdw_invalid_string_format = "HV00A"
        case fdw_invalid_use_of_null_pointer = "HV009"
        case fdw_too_many_handles = "HV014"
        case fdw_out_of_memory = "HV001"
        case fdw_no_schemas = "HV00P"
        case fdw_option_name_not_found = "HV00J"
        case fdw_reply_handle = "HV00K"
        case fdw_schema_not_found = "HV00Q"
        case fdw_table_not_found = "HV00R"
        case fdw_unable_to_create_execution = "HV00L"
        case fdw_unable_to_create_reply = "HV00M"
        case fdw_unable_to_establish_connection = "HV00N"
        case plpgsql_error = "P0000"
        case raise_exception = "P0001"
        case no_data_found = "P0002"
        case too_many_rows = "P0003"
        case assert_failure = "P0004"
        // Class XX — Internal Error
        case internal_error = "XX000"
        case data_corrupted = "XX001"
        case index_corrupted = "XX002"
        case unknown = "Unknown"
     }
}

// MARK: Inits

extension PostgreSQLError {
    public init(_ connection: Connection) {
        let raw = String(cString: PQerrorMessage(connection.cConnection))

        let message: String
        if let error = PQerrorMessage(connection.cConnection) {
            message = String(cString: error)
        } else {
            message = "Unknown"
        }

        self.init(
            rawCode: raw,
            reason: message
        )
    }

    public init(_ code: Code, reason: String) {
        self.code = code
        self.reason = reason
    }

    public init(rawCode: String, reason: String) {
        self.code = Code(rawValue: rawCode) ?? .unknown
        self.reason = reason
    }
}

// MARK: Debuggable
import Debugging

extension PostgreSQLError: Debuggable {
    public static var readableName: String {
        return "PostgreSQL Error"
    }

    public var identifier: String {
        return "\(code.rawValue) (\(code))"
    }

    public var possibleCauses: [String] {
        switch code {
        case .connection_exception, .connection_does_not_exist, .connection_failure:
            return [
                "The connection to the server degraded during the query",
                "The connection has been open for too long",
                "Too much data has been sent through the connection"
            ]
        default:
            return []
        }
    }

    public var suggestedFixes: [String] {
        switch code {
        case .syntax_error:
            return [
                "Fix the invalid syntax in your query",
                "If an ORM has generated this error, report the issue to its GitHub page"
            ]
        case .connection_exception, .connection_does_not_exist, .connection_failure:
            return [
                "Increase the `wait_timeout`",
                "Increase the `max_allowed_packet`"
            ]
        default:
            return []
        }
    }

    public var stackOverflowQuestions: [String] {
        switch code {
        case .syntax_error:
            return [
            ]
        default:
            return []
        }
    }

    public var documentationLinks: [String] {
        return [
        ]
    }
}
