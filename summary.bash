#!/bin/bash

export OLD_GRADLE_LINE="  mediumRetrievalTest group: 'com.onshape.dev.retrieval', name: 'ninth_modeling', version: 'v1364_092320', ext: 'tgz'"
export NEW_GRADLE_LINE="  mediumRetrievalTest group: 'com.onshape.dev.retrieval', name: 'ninth_modeling', version: 'v9999_032923', ext: 'tgz'"
if [[ "new" == "new"  ]]; then
    {
        echo "In \`project/test/test.gradle\`, replace:"
        echo -e "\`\`\`bash\n$OLD_GRADLE_LINE\n\`\`\`"
        echo "with:"
        echo -e "\`\`\`bash\n$NEW_GRADLE_LINE\n\`\`\`"
    } >> $GITHUB_STEP_SUMMARY
fi
