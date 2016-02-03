<#--
Description:
  This is the template to generate the Benchmark class for a particular snippet.
  Every snippet gets a separated class.

  You may modify this template to your needs and make AutoJMH use it by configuring the value of the
  micro-benchmark-template variable setting the path to your new template.
Author:
  Marcelino Rodriguez-Cancio
-->

package ${package_name};

import org.openjdk.jmh.annotations.*;
import java.io.DataInputStream;

<#list imports as import>
import ${import};
</#list>

/**
 *  ${class_comments}
 */
@State(Scope.Thread)
public class ${class_name}_Benchmark {

    static final String DATA_ROOT_FOLDER = "${data_root_folder_path}";
    static final String DATA_FILE = "${data_file_path}";

<#list input_vars as input_var>
    public ${input_var.variableTypeName} ${input_var.templateCodeCompilableName} ;
    <#if input_var.mustReset == true >
    public ${input_var.variableTypeName} ${input_var.templateCodeCompilableName}___reset ;
    </#if>
</#list>

    @Setup(Level.Trial)
    public void setupMicrobenchmark() {
        try {
            Loader ${class_name}_s = new Loader();
            ${class_name}_s.openStream(DATA_ROOT_FOLDER, DATA_FILE);

    <#list input_vars as input_var>
        <#if input_var.initialized == true >
            <#if input_var.mustReset == true >
            ${input_var.templateCodeCompilableName}___reset = ${class_name}_s.read${input_var.loadMethodName}();
            ${input_var.templateCodeCompilableName} = new ${input_var.variableTypeName}();
            <#else>
            ${input_var.templateCodeCompilableName} = ${class_name}_s.read${input_var.loadMethodName}();
            </#if>
        </#if>
    </#list>

            ${class_name}_s.closeStream();
        } catch(Exception e) { throw new RuntimeException(e); }
    }

<#if reset_code >
    @Setup(Level.Invocation)
    public void resetMicrobenchmark() {
      <#list input_vars as input_var>
        <#if input_var.mustReset == true >
            ${input_var.resetCode}
        </#if>
      </#list>
    }
</#if>

    ${static_methods}

    @Benchmark
    <#if black_holes_neded>
    public ${bench_method_type} doBenchmark(BlackHole bh) {
    <#else>
    public ${bench_method_type} doBenchmark() {
    </#if>
        ${snippet_code};



        ${(return_statement)!}
    }
}