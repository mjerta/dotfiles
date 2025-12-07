local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node

luasnip.add_snippets("xml", {
  s("mavenplugin", {
    t({
      "<build>",
      "    <plugins>",
      "        <plugin>",
      "            <groupId>org.apache.maven.plugins</groupId>",
      "            <artifactId>maven-jar-plugin</artifactId>",
      "            <configuration>",
      "                <archive>",
      "                    <manifest>",
      "                        <mainClass>nl.mpdev.App</mainClass>",
      "                    </manifest>",
      "                </archive>",
      "            </configuration>",
      "        </plugin>",
      "    </plugins>",
      "</build>",
    }),
  }),
})
