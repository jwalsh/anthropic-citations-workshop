# First, let's rename the files to more meaningful names
cd assets
mv Gemini_Generated_Image_1e2r111e2r111e2r.jpeg citations-network.jpeg
mv Gemini_Generated_Image_e76tbhe76tbhe76t.jpeg citations-flow.jpeg
mv Gemini_Generated_Image_vxdr53vxdr53vxdr.jpeg rag-system.jpeg
mv Gemini_Generated_Image_djv8fodjv8fodjv8.jpeg citations-graph.jpeg
mv Gemini_Generated_Image_ljpv2oljpv2oljpv.jpeg citations-code.jpeg

# Create an assets README
cat > README.md << 'EOL'
# Workshop Assets

Visual assets for the Anthropic Citations API Workshop:

- `logo.jpg` - Main repository logo
- `citations-network.jpeg` - Citation network visualization
- `citations-flow.jpeg` - Citation flow diagram
- `rag-system.jpeg` - RAG system architecture
- `citations-graph.jpeg` - Citation graph example
- `citations-code.jpeg` - Code and citations visualization

Used in:
- Repository social preview
- Documentation
- Workshop materials
EOL

cd ..

# Stage all assets
git add assets/

# Create commit with structured message
git commit -m "feat(assets): add workshop visuals

- Added repository logo and social preview
- Added system diagrams and visualizations
- Created assets documentation

Visual assets include:
- Citation network diagrams
- RAG system visualizations
- Flow diagrams
- Code integration examples"

# Push changes
git push origin main
