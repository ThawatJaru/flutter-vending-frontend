class PlantStatement {
  final String statement_id;
  final String status;

  PlantStatement(this.statement_id, this.status); //constructor

  @override
  String toString() {
    return 'statement_id: ${this.statement_id}, status:${this.status}';
  }
}
