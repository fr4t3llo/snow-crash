#!/bin/bash

# Loop from level00 to level14
for i in $(seq -w 0 14); do
    level="level$i"
    resources="$level/Resources"
    
    # Create level and Resources folder
    mkdir -p "$resources"
    
    # Create flag file
    touch "$level/flag"
    
    # Create README.md inside Resources
    echo "# Resources for $level" > "$resources/README.md"
    
    echo "Created $level with flag and Resources/README.md"
done
#!/bin/bash

for i in $(seq -w 0 14); do
    level="level$i"
    resources="$level/Resources"
    readme="$resources/README.md"
    
    mkdir -p "$resources"
    touch "$level/flag"

    cat > "$readme" <<EOF
# Resources for $level

## Walkthrough to capture the flag:

### Step 1: Find files owned by user \`flag00\`
\`\`\`bash
find / -user flag00 2>/dev/null
\`\`\`
> Output:
\`\`\`
/usr/sbin/john
/rofs/usr/sbin/john
\`\`\`

### Step 2: Read the encrypted string
\`\`\`bash
cat /rofs/usr/sbin/john
\`\`\`
> Output:
\`\`\`
cdiiddwpgswtgt
\`\`\`

### Step 3: Decrypt it (likely ROT13)
Decrypted password: \`nottoohardhere\`

### Step 4: Switch to \`flag00\` user
\`\`\`bash
su flag00
# enter password: nottoohardhere
\`\`\`

### Step 5: Get the flag
\`\`\`bash
getflag
\`\`\`
> Output:
\`\`\`
Check flag.Here is your token : x24ti5gi3x0ol2eh4esiuxias
\`\`\`
EOF

    echo "✅ Created $readme with walkthrough"
done
