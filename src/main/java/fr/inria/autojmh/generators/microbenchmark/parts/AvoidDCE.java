package fr.inria.autojmh.generators.microbenchmark.parts;

import fr.inria.autojmh.snippets.BenchSnippet;

/**
 * Extract private static method out of an statement and copy its body to the parts
 *
 */
public class AvoidDCE extends AbstractMicrobenchmarkPart {

    @Override
    public String generate(BenchSnippet snippet) {
        return "";
    }

}
