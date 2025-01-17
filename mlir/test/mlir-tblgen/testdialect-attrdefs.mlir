// RUN: mlir-opt %s | mlir-opt -verify-diagnostics | FileCheck %s --strict-whitespace

// CHECK-LABEL: func private @compoundA()
// CHECK-SAME: #test.cmpnd_a<1, !test.smpla, [5, 6]>
func.func private @compoundA() attributes {foo = #test.cmpnd_a<1, !test.smpla, [5, 6]>}

// CHECK: test.result_has_same_type_as_attr #test.attr_with_self_type_param : i32 -> i32
%a = test.result_has_same_type_as_attr #test.attr_with_self_type_param : i32 -> i32

// CHECK: test.result_has_same_type_as_attr #test<attr_with_type_builder 10 : i16> : i16 -> i16
%b = test.result_has_same_type_as_attr #test<attr_with_type_builder 10 : i16> -> i16

// CHECK-LABEL: @qualifiedAttr()
// CHECK-SAME: #test.cmpnd_nested_outer_qual<i #test.cmpnd_nested_inner<42 <1, !test.smpla, [5, 6]>>>
func.func private @qualifiedAttr() attributes {foo = #test.cmpnd_nested_outer_qual<i #test.cmpnd_nested_inner<42 <1, !test.smpla, [5, 6]>>>}

// CHECK-LABEL: @overriddenAttr
// CHECK-SAME: foo = 5 : index
func.func private @overriddenAttr() attributes {
  foo = #test.override_builder<5>
}

// CHECK-LABEL: @newlineAndIndent
// CHECK-SAME:  indent = #test.newline_and_indent<
// CHECK-NEXT:    !test.newline_and_indent<    
// CHECK-NEXT:      indented_content
// CHECK-NEXT:    >
// CHECK-NEXT:  >
func.func private @newlineAndIndent() attributes {
  indent = #test.newline_and_indent<
    !test.newline_and_indent<
      indented_content
    >
  >
}
